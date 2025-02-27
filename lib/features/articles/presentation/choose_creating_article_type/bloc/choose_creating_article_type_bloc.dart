import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_type_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'choose_creating_article_type_event.dart';
import 'choose_creating_article_type_state.dart';

class ChooseCreatingArticleTypeBloc extends Bloc<ChooseCreatingArticleTypeEvent,
    ChooseCreatingArticleTypeState> {
  final ArticleTypeRepository articleTypeRepository;
  final CompanyRepository companyRepository;
  List<ArticleType> articleTypes = [];

  ChooseCreatingArticleTypeBloc({
    required this.articleTypeRepository,
    required this.companyRepository,
  }) : super(ChooseCreatingArticleTypeLoadInProgressState()) {
    on<ChooseCreatingArticleTypeLoadEvent>(_onStart);
    on<ChooseCreatingArticleTypeRefreshEvent>(_onRefresh);
    on<ChooseCreatingArticleTypeHandleButtonEvent>(_onChoose);
    add(ChooseCreatingArticleTypeLoadEvent());
  }

  Future<void> _onStart(ChooseCreatingArticleTypeLoadEvent event,
      Emitter<ChooseCreatingArticleTypeState> emit) async {
    try {
      var company = await companyRepository.getCurrent();
      this.articleTypes =
          await articleTypeRepository.getVisibleList(company!.uuid);

      emit(ChooseCreatingArticleTypeLoadSuccessState(this.articleTypes));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(ChooseCreatingArticleTypeLoadFailureState());
    }
  }

  Future<void> _onRefresh(ChooseCreatingArticleTypeRefreshEvent event,
      Emitter<ChooseCreatingArticleTypeState> emit) async {
    try {
      emit(ChooseCreatingArticleTypeLoadInProgressState());

      var company = await companyRepository.getCurrent();
      this.articleTypes =
          await articleTypeRepository.getVisibleList(company!.uuid);

      emit(ChooseCreatingArticleTypeLoadSuccessState(this.articleTypes));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(ChooseCreatingArticleTypeLoadFailureState());
    }
    if (!event.refreshCompleter.isCompleted) {
      event.refreshCompleter.complete();
    }
  }

  Future<void> _onChoose(ChooseCreatingArticleTypeHandleButtonEvent event,
      Emitter<ChooseCreatingArticleTypeState> emit) async {
    try {
      var company = await companyRepository.getCurrent();
      this.articleTypes =
          await articleTypeRepository.getVisibleList(company!.uuid);
      emit(ChooseCreatingArticleTypeChoosenState(event.articleTypeId));
      emit(ChooseCreatingArticleTypeLoadSuccessState(this.articleTypes));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(ChooseCreatingArticleTypeLoadFailureState());
    }
  }
}
