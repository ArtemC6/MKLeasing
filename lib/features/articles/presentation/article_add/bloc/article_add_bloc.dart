import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/features/articles/domain/models/article_response.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_type_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'article_add_event.dart';
import 'article_add_state.dart';

class ArticleAddBloc extends Bloc<ArticleAddEvent, ArticleAddState> {
  final ArticleRepository articleRepository;
  final ArticleTypeRepository articleTypeRepository;
  final CompanyRepository companyRepository;

  final int articleTypeId;

  ArticleAddBloc({
    required this.articleTypeId,
    required this.companyRepository,
    required this.articleRepository,
    required this.articleTypeRepository,
  }) : super(ArticleAddState(loading: true)) {
    on<ArticleAddStoreEvent>(_onStore);
    on<ArticleAddLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      ArticleAddLoadEvent event, Emitter<ArticleAddState> emit) async {
    ArticleType? articleType =
        await articleTypeRepository.getById(articleTypeId);
    List<ArticleTypeProperty> articleTypeProperties =
        await articleTypeRepository.getPropertiesForArticleType(
            articleType!.companyUuid, articleType.id);

    emit(state.copyWith(
        loading: false,
        articleType: articleType,
        articleTypeProperties: articleTypeProperties));
    // emit(ArticleAddsState(articleType, articleTypeProperties));
  }

  Future<void> _onStore(
      ArticleAddStoreEvent event, Emitter<ArticleAddState> emit) async {
    try {
      emit(state.copyWith(sending: true));
      var company = await companyRepository.getCurrent();
      final articleStoreResponse = await articleRepository.store(
        companyUuid: company!.uuid,
        articleType: event.articleType,
        properties: event.properties,
      );

      if (articleStoreResponse is SuccessArticleStoreResponse) {
        emit(ArticleAddSuccessState());
        return;
      }

      if (articleStoreResponse is ValidationFailedArticleStoreResponse) {
        emit(state.copyWith(
            sending: false, errors: articleStoreResponse.errors));
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(ArticleAddFailureState());
    }
  }
}
