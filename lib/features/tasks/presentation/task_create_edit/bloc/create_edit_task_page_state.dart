part of 'create_edit_task_page_bloc.dart';

class CreateEditTaskPageState {
  final CompanyEntity? currentCompany;
  String address;
  final bool isNeedSendToApproval;
  DateTime? startExecutionAt;
  DateTime? finishExecutionAt;
  final TaskPriority? priority;
  final ArticleMiniEntity? selectedArticle;
  final ReviewTemplateMiniEntity? selectedReviewTemplate;
  final List<ReviewTemplateMiniEntity>? listReviewTemplates;
  final List<ArticleMiniEntity>? listArticles;
  final bool? hasArticles;
  final bool needPop;
  final bool isNeedHideValidateResults;
  final bool isButtonActive;

  CreateEditTaskPageState({
    this.hasArticles,
    this.currentCompany,
    this.address = '',
    this.isNeedSendToApproval = true,
    this.startExecutionAt,
    this.finishExecutionAt,
    this.priority,
    this.selectedArticle,
    this.selectedReviewTemplate,
    this.listReviewTemplates,
    this.listArticles,
    this.needPop = false,
    this.isNeedHideValidateResults = true,
    this.isButtonActive = true,
  });

  CreateEditTaskPageState copyWith({
    CompanyEntity? currentCompany,
    String? address,
    bool? isNeedSendToApproval,
    DateTime? startExecutionAt,
    DateTime? finishExecutionAt,
    TaskPriority? priority,
    ArticleMiniEntity? selectedArticle,
    ReviewTemplateMiniEntity? selectedReviewTemplate,
    List<ReviewTemplateMiniEntity>? listReviewTemplates,
    List<ArticleMiniEntity>? listArticles,
    bool? hasArticles,
    String? companyUuid,
    bool? needPop,
    bool? isNeedHideValidateResults,
    bool? isButtonActive,
  }) {
    return CreateEditTaskPageState(
      currentCompany: currentCompany ?? this.currentCompany,
      address: address ?? this.address,
      isNeedHideValidateResults:
          isNeedHideValidateResults ?? this.isNeedHideValidateResults,
      isNeedSendToApproval: isNeedSendToApproval ?? this.isNeedSendToApproval,
      startExecutionAt: startExecutionAt ?? this.startExecutionAt,
      finishExecutionAt: finishExecutionAt ?? this.finishExecutionAt,
      priority: priority ?? this.priority,
      needPop: needPop ?? this.needPop,
      selectedArticle: selectedArticle != null
          ? selectedArticle.remoteId == -1
              ? null
              : selectedArticle
          : this.selectedArticle,
      selectedReviewTemplate:
          selectedReviewTemplate ?? this.selectedReviewTemplate,
      listReviewTemplates: listReviewTemplates ?? this.listReviewTemplates,
      listArticles: listArticles != null
          ? listArticles
          : this.listArticles,
      hasArticles: hasArticles != null
          ? hasArticles
          : this.hasArticles,
      isButtonActive: isButtonActive?? this.isButtonActive,
    );
  }

  bool isDataChanged() {
    return selectedArticle != null ||
        selectedReviewTemplate != null ||
        address.isNotEmpty ||
        startExecutionAt != null ||
        finishExecutionAt != null ||
        priority != null;
  }
}
