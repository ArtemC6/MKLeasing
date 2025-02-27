import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/home/services/reviews_count_service.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/background_downloader_service.dart';
import 'package:mutex/mutex.dart';

class DataService extends Api {
  final ReviewsCountService _reviewsCountService = getIt();
  Mutex mtx = Mutex();

  /// Метод получения всех данных за один запрос и дальнейшее их сохранение по
  /// принципу "всё или ничего".
  Future<http.Response> getData() async => await Api.client.get(
        Uri.parse(this.url + "/v2/data"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + this.appBox.get('accessToken'),
        },
      ).timeout(
        Duration(seconds: 15),
      );

  /// Метод обновления всех данных за один раз по принципу "всё или ничего".
  Future syncAllData() async {
    await mtx.acquire();
    try {
      await _syncAllData();
    } catch (e) {
      mtx.release();
      rethrow;
    }
    mtx.release();
  }

  Future _syncAllData() async {
    try {
      final http.Response response = await this.getData();
      if (response.statusCode != 200) {
        throw Exception('Bad response status code');
      }

      final dynamic json = jsonDecode(response.body);

      await parseJson(json);

      await _reviewsCountService.updateData();

      downloadReviewTemplatesFiles('');
      // await FlutterIsolate.spawn(downloadReviewTemplatesFiles, 'start');
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      await _reviewsCountService.updateData();
      rethrow;
    }
  }

  Future<void> parseJson(json) async {
    return database.transaction(() async {
      await clear();

      var futures = (json['companies'] as List).map((companyJson) async => await _insertCompany(companyJson)).toList();
      await Future.wait(futures);
    });
  }

  Future<void> clear() async {
    await database.delete(database.companies).go();

    await database.delete(database.reviewTemplateArticles).go();
    await database.delete(database.articleTypeProperties).go();
    await database.delete(database.articleTypes).go();
    await database.delete(database.articles).go();
    await (database.delete(database.reviewTemplateSteps)..where((tbl) => tbl.parentId.isNull())).go();
    await (database.delete(database.reviewSections)..where((tbl) => tbl.parentId.isNull())).go();
    await (database.delete(database.reviewTemplateFormFields)..where((tbl) => tbl.parentId.isNull())).go();
    await (database.delete(database.reviewTemplateForms)..where((tbl) => tbl.parentId.isNull())).go();
    await (database.delete(database.reviewTemplates)
          ..where((tbl) => tbl.parentId.isNull())
          ..where((tbl) => tbl.isOpened.equals(false)))
        .go();
    await database.delete(database.helpQuestions).go();
  }

  Future<void> _insertCompany(dynamic companyJson) async {
    await database.into(database.companies).insert(CompaniesCompanion.insert(
          remoteUuid: companyJson['uuid'],
          name: companyJson['name'],
          canCreateArticles: companyJson['config']['can_create_articles'],
          phone: Value(companyJson['config']['phone']),
          email: Value(companyJson['config']['email']),
        ));

    Company company = await (database.select(database.companies)..where((tbl) => tbl.remoteUuid.equals(companyJson['uuid']))).getSingle();

    await Future.wait((companyJson['article_types'] as List).map((articleTypeJson) async => await _insertArticleType(company, articleTypeJson)).toList());

    await Future.wait((companyJson['templates'] as List).map((templateJson) async => await _insertReviewTemplate(company, templateJson)).toList());

    await Future.wait((companyJson['articles'] as List).map((articleJson) async => await _insertArticle(company, articleJson)).toList());

    await Future.wait((companyJson['articles'] as List).map((articleJson) async => await _insertReviewTemplateArticle(company, articleJson)).toList());

    await Future.wait((companyJson['help_questions'] as List).map((helpQuestionJson) async => await _insertHelpQuestion(company, helpQuestionJson)).toList());
    if (companyJson['info_modal'] != null) {
      await _insertInfoModal(companyJson['info_modal']);
    }
  }

  Future<void> _insertInfoModal(Map<String, dynamic> map) async {
    final reviewRequest = await (database.select(database.infoModals)..where((tbl) => tbl.type.contains('review_request'))).get();
    final reviewRework = await (database.select(database.infoModals)..where((tbl) => tbl.type.contains('review_rework'))).get();
    {
      await database.into(database.infoModals).insertOnConflictUpdate(
            InfoModalsCompanion.insert(
              enable: map['review_request']['enable'],
              titleTemplate: map['review_request']['title_template'],
              textTemplate: map['review_request']['text_template'],
              type: 'review_request',
              id: reviewRequest.isEmpty ? Value.absent() : Value(reviewRequest.first.id),
            ),
          );
    }

    await database.into(database.infoModals).insertOnConflictUpdate(
          InfoModalsCompanion.insert(
            enable: map['review_rework']['enable'],
            titleTemplate: map['review_rework']['title_template'],
            textTemplate: map['review_rework']['text_template'],
            type: 'review_rework',
            id: reviewRework.isEmpty ? Value.absent() : Value(reviewRework.first.id),
          ),
        );
  }

  Future<void> _insertReviewTemplate(Company company, dynamic templateJson) async {
    final isEnabled = (await (database.select(database.reviewTemplates)
                  ..where((tbl) => tbl.remoteId.equals(templateJson['id']))
                  ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
                  ..limit(1))
                .getSingleOrNull())
            ?.isOpened ??
        false;
    await database.into(database.reviewTemplates).insertOnConflictUpdate(ReviewTemplatesCompanion.insert(
          remoteId: templateJson['id'],
          companyUuid: company.remoteUuid,
          name: templateJson['name'],
          description: Value(templateJson['description']),
          expandable: templateJson['expandable'],
          private: templateJson['private'],
          isRework: Value(templateJson['is_rework']),
          repeatable: templateJson['repeatable'],
          rejectionAvailable: Value(templateJson['rejection_available']),
          delegationAvailable: Value(templateJson['delegation_available']),
          simpleSignatureFile: Value(templateJson['simple_signature_file']),
          simpleSignatureEnabled: Value(templateJson['simple_signature_enabled']),
          isOpened: Value(isEnabled),
        ));

    ReviewTemplate template = (await (database.select(database.reviewTemplates)
              ..where((tbl) => tbl.parentId.isNull() & tbl.remoteId.equals(templateJson['id']) & tbl.companyUuid.equals(company.remoteUuid)))
            .get())
        .last;

    await Future.wait((templateJson['steps'] as List).map((stepJson) async => await _insertReviewTemplateStep(company, template, stepJson)).toList());

    if (templateJson['sections'] != null) {
      await Future.forEach((templateJson['sections'] as List), (sectionJson) async => await _insertReviewTemplateSections(company, template, sectionJson));
    }
  }

  Future<void> _insertReviewTemplateStep(Company company, ReviewTemplate template, dynamic stepJson) async {
    var form = stepJson['form'] != null ? await _insertReviewTemplateForm(company, stepJson['form']) : null;

    if (stepJson != null) {
      await database.into(database.reviewTemplateSteps).insert(
            ReviewTemplateStepsCompanion.insert(
              remoteId: Value(stepJson['id']),
              remoteUuid: Value(stepJson['uuid']),
              companyUuid: company.remoteUuid,
              type: stepJson['type'],
              title: stepJson['title'],
              subtitle: Value(stepJson['subtitle']),
              comment: Value(stepJson['comment']),
              contentImage: Value(stepJson['content_image']),
              contentMask: Value(stepJson['content_mask']),
              contentText: Value(stepJson['content_text']),
              required: stepJson['required'],
              expandable: stepJson['expandable'],
              repeatable: stepJson['repeatable'],
              canHaveViolation: stepJson['can_have_violation'],
              weight: stepJson['weight'],
              templateId: template.remoteId,
              isSelfCreated: Value(false),
              multimedia: Value(stepJson['multimedia'] != null ? jsonEncode(stepJson['multimedia']) : null),
              formId: Value(form?.id),
              requiredCommentWhenSkipping: Value(
                stepJson['required_comment_when_skipping'],
              ),
              sectionId: Value(stepJson['review_template_section_id']),
            ),
          );
    } else {}
  }

  Future<void> _insertReviewTemplateSections(Company company, ReviewTemplate template, dynamic section) async {
    int localSectionId = await database.into(database.reviewSections).insert(
          ReviewSectionsCompanion.insert(
            remoteId: Value(section['id']),
            templateId: template.id,
            title: section['title'],
            subtitle: Value(section['subtitle']),
            description: Value(section['description']),
            uuid: section['uuid'],
            repeatable: section['repeatable'],
            // TODO: section.repeatable - это фактически copyable, допущена ошибка в нейминге на бэкенде
            isSelfCreated: false,
          ),
        );

    await (database.update(database.reviewTemplateSteps)..where((tbl) => tbl.sectionId.equals(section['id']) & tbl.companyUuid.equals(company.remoteUuid)))
        .write(ReviewTemplateStepsCompanion(
      localSectionId: Value(localSectionId),
    ));
  }

  Future _insertReviewTemplateForm(Company company, dynamic formJson) async {
    var id = await database.into(database.reviewTemplateForms).insert(ReviewTemplateFormsCompanion.insert(
          remoteId: formJson['id'],
          slug: formJson['slug'],
          description: Value(formJson['description']),
          companyUuid: company.remoteUuid,
          title: formJson['title'],
        ));

    var form = await (database.select(database.reviewTemplateForms)..where((tbl) => tbl.id.equals(id))).getSingle();

    (formJson['fields'] as List).forEach((fieldJson) async => await _insertReviewTemplateFormField(company, form, fieldJson));

    return form;
  }

  Future<void> _insertReviewTemplateFormField(Company company, ReviewTemplateForm form, dynamic fieldJson) async {
    await database.into(database.reviewTemplateFormFields).insert(ReviewTemplateFormFieldsCompanion.insert(
          remoteId: fieldJson['id'],
          companyUuid: company.remoteUuid,
          title: fieldJson['title'],
          slug: fieldJson['slug'],
          type: fieldJson['type']['keyword'],
          weight: fieldJson['weight'],
          formId: form.id,
          properties: jsonEncode(fieldJson['properties']),
        ));
  }

  Future<void> _insertArticle(Company company, dynamic articleJson) async {
    var articleType = await (database.select(database.articleTypes)
          ..where((tbl) => tbl.remoteId.equals(articleJson['type_id']) & tbl.companyUuid.equals(company.remoteUuid)))
        .getSingle();
    final id = await database.into(database.articles).insert(ArticlesCompanion.insert(
        remoteId: articleJson['id'],
        companyUuid: company.remoteUuid,
        title: articleJson['title'],
        subtitle: Value.ofNullable(articleJson['subtitle'] ?? ''),
        typeId: articleType.remoteId,
        lastNotificationStatusKeyword: articleJson['last_notification']['status']['keyword'],
        parentsIds: Value.ofNullable((articleJson['parents_ids'] ?? []).toString())));

    (articleJson['properties'] as List<dynamic>).forEach((element) async {
      await _insertArticleProperties(id, element);
    });
  }

  Future<void> _insertArticleProperties(int articleId, dynamic propertyJson) async {
    await database.into(database.propertiesArticles).insert(
          PropertiesArticlesCompanion.insert(
            name: Value(propertyJson['name']),
            value: Value(propertyJson['value']),
            articleId: Value(articleId),
          ),
        );
  }

  Future<void> _insertReviewTemplateArticle(Company company, dynamic articleJson) async {
    var article = await (database.select(database.articles)
          ..where((tbl) => tbl.remoteId.equals(articleJson['id']) & tbl.companyUuid.equals(company.remoteUuid)))
        .getSingle();

    var futures = articleJson['templates_ids'].map<Future>((templateId) async {
      var template = (await (database.select(database.reviewTemplates)
                ..where((tbl) => tbl.parentId.isNull() & tbl.remoteId.equals(templateId) & tbl.companyUuid.equals(company.remoteUuid)))
              .get())
          .last;

      await database
          .into(database.reviewTemplateArticles)
          .insert(ReviewTemplateArticlesCompanion.insert(companyUuid: company.remoteUuid, articleId: article.id, templateId: template.id));
    });

    await Future.wait(futures);
  }

  Future<void> _insertHelpQuestion(Company company, dynamic helpQuestionJson) async {
    await database.into(database.helpQuestions).insert(HelpQuestionsCompanion.insert(
          remoteId: helpQuestionJson['id'],
          companyUuid: company.remoteUuid,
          title: helpQuestionJson['title'],
          description: helpQuestionJson['description'],
          weight: helpQuestionJson['weight'],
        ));
  }

  Future<void> _insertArticleType(Company company, dynamic articleTypeJson) async {
    await database.into(database.articleTypes).insert(ArticleTypesCompanion.insert(
          remoteId: articleTypeJson['id'],
          companyUuid: company.remoteUuid,
          name: articleTypeJson['name'],
          visibleForCreating: articleTypeJson['visible_for_creating'],
        ));

    ArticleType articleType = await (database.select(database.articleTypes)
          ..where((tbl) => tbl.remoteId.equals(articleTypeJson['id']) & tbl.companyUuid.equals(company.remoteUuid)))
        .getSingle();

    (articleTypeJson['fields'] as List).forEach((articleTypeFieldJson) => _insertArticleTypeProperty(company, articleType, articleTypeFieldJson));
  }

  Future<void> _insertArticleTypeProperty(Company company, ArticleType articleType, dynamic articleTypePropertyJson) async {
    await database.into(database.articleTypeProperties).insert(ArticleTypePropertiesCompanion.insert(
          remoteId: articleTypePropertyJson['id'],
          companyUuid: company.remoteUuid,
          typeId: articleType.id,
          weight: articleTypePropertyJson['weight'],
          title: articleTypePropertyJson['title'],
          type: articleTypePropertyJson['type'],
          slug: articleTypePropertyJson['slug'],
          required: articleTypePropertyJson['required'],
        ));
  }
}
