import 'package:leasing_company/core/config/models/config_model.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_proxy.dart';

abstract class ChooseReviewTemplateState {}

class ChooseReviewTemplateLoadInProgressState
    extends ChooseReviewTemplateState {}

class ChooseReviewTemplateLoadSuccessState extends ChooseReviewTemplateState {
  final CompanyEntity company;
  final Config config;
  final List<ReviewTemplateProxy> articleTemplatesProxies;

  ChooseReviewTemplateLoadSuccessState({
    required this.company,
    required this.config,
    required this.articleTemplatesProxies,
  });
}

class ChooseReviewTemplateLoadFailureState extends ChooseReviewTemplateState {}
