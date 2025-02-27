import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/review_template_form_step/bloc/review_template_form_step_event.dart';
import 'package:leasing_company/features/make_report/presentation/review_template_form_step/bloc/review_template_form_step_state.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_form_field_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ReviewTemplateFormStepBloc
    extends Bloc<ReviewTemplateFormStepEvent, ReviewTemplateFormStepState> {
  final reviewTemplateFormFieldRepository =
      getIt<ReviewTemplateFormFieldRepository>();

  CompanyEntity company;
  ReviewTemplateStepFormModel form;

  ReviewTemplateFormStepBloc({required this.company, required this.form})
      : super(ReviewTemplateFormStepLoadInProgressState()) {
    on<ReviewTemplateFormStepLoadEvent>(_mapLoadToState);
    on<UpdatePageUiEvent>(_onUpdatePageUiEvent);
  }

  Future<void> _mapLoadToState(ReviewTemplateFormStepLoadEvent event,
      Emitter<ReviewTemplateFormStepState> emit) async {
    try {
      emit(ReviewTemplateFormStepLoadInProgressState());

      List<ReviewTemplateFormField> fields =
          await reviewTemplateFormFieldRepository.getFieldsForForm(
              this.company.uuid, this.form.localId!);

      emit(ReviewTemplateFormStepReadyState(fields: fields));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  void _onUpdatePageUiEvent(_, Emitter<ReviewTemplateFormStepState> emit) {
    if(state is ReviewTemplateFormStepReadyState){
      emit((state as ReviewTemplateFormStepReadyState).copy());
    }
  }
}
