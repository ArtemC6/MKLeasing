import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'drift.g.dart';

@DataClassName('Company')
class Companies extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get remoteUuid => text()();

  TextColumn get name => text()();

  BoolColumn get canCreateArticles => boolean()();

  TextColumn get phone => text().nullable()();

  TextColumn get email => text().nullable()();
}

@DataClassName('ArticleType')
class ArticleTypes extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer()();

  TextColumn get companyUuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  TextColumn get name => text()();

  BoolColumn get visibleForCreating => boolean()();
}

@DataClassName('ArticleTypeProperty')
class ArticleTypeProperties extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer()();

  TextColumn get companyUuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  IntColumn get typeId => integer().references(ArticleTypes, #id)();

  TextColumn get title => text()();

  TextColumn get slug => text()();

  TextColumn get type => text()();

  BoolColumn get required => boolean()();

  IntColumn get weight => integer()();
}

@DataClassName('Article')
class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer()();

  TextColumn get companyUuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  IntColumn get typeId => integer().references(ArticleTypes, #id)();

  TextColumn get title => text()();

  TextColumn get subtitle => text().nullable()();

  TextColumn get lastNotificationStatusKeyword => text()();

  TextColumn get parentsIds => text().nullable()();

  // IntColumn get properties => integer().references(PropertiesArticles, #id)();
}

@DataClassName('ReviewTemplate')
class ReviewTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer()();

  IntColumn get parentId => integer().nullable()();

  TextColumn get companyUuid => text()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  BoolColumn get expandable => boolean()();

  BoolColumn get repeatable => boolean()();

  BoolColumn get private => boolean()();

  BoolColumn get isRework => boolean().withDefault(Constant(false))();

  BoolColumn get rejectionAvailable => boolean().withDefault(Constant(false))();

  BoolColumn get delegationAvailable => boolean().withDefault(Constant(false))();

  TextColumn get simpleSignatureFile => text().nullable()();

  BoolColumn get simpleSignatureEnabled => boolean().nullable()();

  BoolColumn get isOpened => boolean().withDefault(Constant(false))();
}

@DataClassName('ReviewTemplateForm')
class ReviewTemplateForms extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer()();

  IntColumn get parentId => integer().nullable()();

  TextColumn get companyUuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  TextColumn get title => text()();

  TextColumn get slug => text()();

  TextColumn get description => text().nullable()();
}

@DataClassName('ReviewTemplateFormField')
class ReviewTemplateFormFields extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer()();

  IntColumn get parentId => integer().nullable()();

  TextColumn get companyUuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  IntColumn get formId => integer().references(ReviewTemplateForms, #id)();

  TextColumn get type => text()();

  TextColumn get title => text()();

  TextColumn get slug => text()();

  TextColumn get properties => text()();

  IntColumn get weight => integer()();
}

@DataClassName('ReviewTemplateStep')
class ReviewTemplateSteps extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer().nullable()();

  IntColumn get parentId => integer().nullable()();

  TextColumn get remoteUuid => text().nullable()();

  TextColumn get companyUuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  IntColumn get templateId => integer().references(ReviewTemplates, #id)();

  TextColumn get reviewUuid => text().nullable()();

  TextColumn get type => text()();

  TextColumn get title => text()();

  TextColumn get subtitle => text().nullable()();

  TextColumn get contentText => text().nullable()();

  TextColumn get contentImage => text().nullable()();

  TextColumn get contentMask => text().nullable()();

  IntColumn get weight => integer()();

  BoolColumn get required => boolean()();

  TextColumn get multimedia => text().nullable()();

  BoolColumn get requiredCommentWhenSkipping => boolean().withDefault(Constant(true))();

  BoolColumn get expandable => boolean()();

  BoolColumn get repeatable => boolean()();

  BoolColumn get canHaveViolation => boolean()();

  BoolColumn get isSelfCreated => boolean().withDefault(Constant(false))();

  TextColumn get comment => text().nullable()();

  IntColumn get formId => integer().nullable().references(ReviewTemplateForms, #id)();

  IntColumn get sectionId => integer().nullable()();

  IntColumn get localSectionId => integer().nullable()();

  // deprecated
  BoolColumn get multiple => boolean().nullable()();
  // deprecated
  TextColumn get limitFiles => text().nullable()();
  // deprecated
  TextColumn get limitVideoDuration => text().nullable()();
}

@DataClassName('ReviewTemplateArticle')
class ReviewTemplateArticles extends Table {
  TextColumn get companyUuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  IntColumn get templateId => integer().references(ReviewTemplates, #id)();

  IntColumn get articleId => integer().references(Articles, #id)();

  @override
  Set<Column> get primaryKey => {companyUuid, templateId, articleId};
}

@DataClassName('Review')
class Reviews extends Table {
  TextColumn get uuid => text()();

  TextColumn get companyUuid => text()();

  IntColumn get articleId => integer().nullable()();

  IntColumn get remoteArticleId => integer()();

  IntColumn get templateId => integer()();

  IntColumn get remoteTemplateId => integer()();

  IntColumn get remoteTaskId => integer().nullable()();

  BoolColumn get offline => boolean()();

  DateTimeColumn get startedAt => dateTime()();

  DateTimeColumn get onDeviceStartedAt => dateTime()();

  DateTimeColumn get startPointUploadedAt => dateTime().nullable()();

  DateTimeColumn get interruptedAt => dateTime().nullable()();

  DateTimeColumn get onDeviceInterruptedAt => dateTime().nullable()();

  DateTimeColumn get interruptPointUploadedAt => dateTime().nullable()();

  DateTimeColumn get finishedAt => dateTime().nullable()();

  DateTimeColumn get onDeviceFinishedAt => dateTime().nullable()();

  DateTimeColumn get finishedUploadedAt => dateTime().nullable()();

  DateTimeColumn get violationsUploadedAt => dateTime().nullable()();

  DateTimeColumn get commentsUploadedAt => dateTime().nullable()();

  DateTimeColumn get deletingMediaUploadedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {uuid, companyUuid};
}

@DataClassName('ReviewStepFile')
class ReviewStepFiles extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text()();

  TextColumn get reviewUuid => text()();

  IntColumn get stepId => integer()();

  TextColumn get type => text()();

  TextColumn get path => text().nullable()();

  TextColumn get compressedPath => text().nullable()();

  TextColumn get comment => text().nullable()();

  TextColumn get hash => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get onDeviceCreatedAt => dateTime()();

  DateTimeColumn get uploadedAt => dateTime().nullable()();

  DateTimeColumn get deletedByUserAt => dateTime().nullable()();
}

class ReviewLocations extends Table {
  TextColumn get uuid => text()();

  TextColumn get reviewUuid => text()();

  RealColumn get latitude => real()();

  RealColumn get longitude => real()();

  RealColumn get accuracy => real()();

  BoolColumn get mocked => boolean().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get onDeviceCreatedAt => dateTime()();

  DateTimeColumn get gpsCreatedAt => dateTime()();

  DateTimeColumn get uploadedAt => dateTime().nullable()();
}

@DataClassName('ReviewStepViolation')
class ReviewStepViolations extends Table {
  TextColumn get companyUuid => text()();

  TextColumn get reviewUuid => text()();

  IntColumn get stepId => integer()();

  @override
  Set<Column> get primaryKey => {companyUuid, reviewUuid, stepId};
}

@DataClassName('Upload')
class Uploads extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get taskId => text()(); // uuid

  TextColumn get reviewUuid => text()();

  TextColumn get entityType => text()();

  TextColumn get entityAction => text()();

  TextColumn get entityId => text()();

  IntColumn get progress => integer()();

  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get onDeviceCreatedAt => dateTime()();

  DateTimeColumn get uploadedAt => dateTime().nullable()();
}

@DataClassName('HelpQuestion')
class HelpQuestions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer()();

  TextColumn get companyUuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  TextColumn get title => text()();

  TextColumn get description => text()();

  IntColumn get weight => integer()();
}

@DataClassName('ReviewSection')
class ReviewSections extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer().nullable()();

  IntColumn get templateId => integer()();

  IntColumn get parentId => integer().nullable()();

  TextColumn get uuid => text().references(Companies, #remoteUuid, onDelete: KeyAction.cascade)();

  TextColumn get title => text()();

  TextColumn get subtitle => text().nullable()();

  TextColumn get description => text().nullable()();

  BoolColumn get repeatable => boolean()(); // TODO: section.repeatable - это фактически copyable, допущена ошибка в нейминге на бэкенде

  BoolColumn get isSelfCreated => boolean()();
}

@DataClassName('PropertiesArticle')
class PropertiesArticles extends Table {
  TextColumn get name => text().nullable()();

  TextColumn get value => text().nullable()();

  IntColumn get articleId => integer().nullable()();
}

@DataClassName('InfoModal')
class InfoModals extends Table {
  IntColumn get id => integer().autoIncrement()();

  BoolColumn get enable => boolean()();

  TextColumn get titleTemplate => text()();

  TextColumn get textTemplate => text()();

  TextColumn get type => text()();
}

@DriftDatabase(tables: [
  Companies,
  ArticleTypes,
  ArticleTypeProperties,
  Articles,
  ReviewTemplates,
  ReviewTemplateForms,
  ReviewTemplateFormFields,
  ReviewTemplateSteps,
  ReviewTemplateArticles,
  Reviews,
  ReviewLocations,
  ReviewStepFiles,
  ReviewStepViolations,
  Uploads,
  HelpQuestions,
  ReviewSections,
  PropertiesArticles,
  InfoModals,
])

///  Use this command for generate code:
///     flutter pub run build_runner build --delete-conflicting-outputs

class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 16;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) async {
      await m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // 19.12.2022
        await m.alterTable(
          TableMigration(reviewTemplates, columnTransformer: {
            reviewTemplates.description: reviewTemplates.description.cast<String>(), // change to nullable
          }),
        );
      }
      if (from < 3) {
        // 25.12.2022
        await m.addColumn(articleTypes, articleTypes.visibleForCreating);
      }
      if (from < 4) {
        await m.alterTable(TableMigration(reviews, columnTransformer: {
          reviews.articleId: reviews.articleId.cast<String>(),
          reviews.remoteArticleId: reviews.remoteArticleId.cast<String>(),
        }, newColumns: [
          reviews.remoteTaskId,
          reviews.commentsUploadedAt,
          reviews.deletingMediaUploadedAt,
          reviews.violationsUploadedAt,
        ]));

        await m.alterTable(TableMigration(reviewTemplateForms, columnTransformer: {
          reviewTemplateForms.description: reviewTemplateForms.description.cast<String>(),
        }));

        await m.alterTable(TableMigration(reviewTemplateSteps, columnTransformer: {
          reviewTemplateSteps.subtitle: reviewTemplateSteps.subtitle.cast<String>(),
        }));
      }
      if (from < 5) {
        await m.addColumn(reviewTemplateSteps, reviewTemplateSteps.requiredCommentWhenSkipping);
      }
      if (from < 6) {
        await m.addColumn(reviewTemplateSteps, reviewTemplateSteps.multimedia);
      }
      if (from < 7) {
        await m.createTable(reviewSections);
        await m.addColumn(reviewTemplateSteps, reviewTemplateSteps.sectionId);
        await m.addColumn(reviewTemplateSteps, reviewTemplateSteps.localSectionId);
        await m.addColumn(reviewTemplateSteps, reviewTemplateSteps.isSelfCreated);
      }
      if (from < 8) {
        await m.alterTable(TableMigration(reviewTemplateSteps, columnTransformer: {
          reviewTemplateSteps.multiple: reviewTemplateSteps.multiple.cast<bool>(),
          reviewTemplateSteps.limitFiles: reviewTemplateSteps.limitFiles.cast<String>(),
          reviewTemplateSteps.limitVideoDuration: reviewTemplateSteps.limitVideoDuration.cast<String>(),
        }));
      }
      if (from < 9) {
        await m.alterTable(TableMigration(reviewSections, columnTransformer: {
          reviewSections.remoteId: reviewSections.remoteId.cast<int>(),
        }));
      }
      if (from < 10) {
        // 07.12.2023
        await m.addColumn(
          reviewTemplates,
          reviewTemplates.rejectionAvailable,
        );
        await m.addColumn(reviewTemplates, reviewTemplates.delegationAvailable);
      }
      if (from < 11) {
        // 19.02.2024
        await m.addColumn(reviewTemplates, reviewTemplates.isRework);
      }

      if (from <= 12) {
        await m.addColumn(articles, articles.parentsIds);
      }

      if (from <= 13) {
        await m.addColumn(articles, articles.subtitle);

        await m.addColumn(reviewTemplates, reviewTemplates.simpleSignatureFile);
        await m.addColumn(reviewTemplates, reviewTemplates.simpleSignatureEnabled);
      }
      if (from <= 14) {
        await m.createTable(infoModals);
        await m.addColumn(reviewTemplates, reviewTemplates.isOpened);
      }
      if (from <= 15) {
        //10.08.2024
        await m.addColumn(reviewTemplateSteps, reviewTemplateSteps.repeatable);
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    var file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, setup: (db) {
      // db.execute('PRAGMA journal_mode=WAL');
      // db.execute('PRAGMA busy_timeout=30000');
    });
  });
}
