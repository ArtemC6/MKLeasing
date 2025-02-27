import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/domain/models/article_mini_model.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/main.dart';

part 'passport_event.dart';
part 'passport_state.dart';

class PassportBloc extends Bloc<PassportEvent, PassportState> {
  final _articleRepository = getIt<ArticleRepository>();

  PassportBloc() : super(PassportInitial()) {
    on<GetPassportProperties>(_getArticleTypes);
  }

  void _getArticleTypes(GetPassportProperties event, Emitter<PassportState> emit) async {
    final property = await _articleRepository.getArticleType(
      companyUuid: event.companyUuid,
      articleTypeId: event.article.typeId,
    );
    
    emit(PassportTypesLoaded(property));
  }
}
