import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_date_picker_widget.dart';
import 'package:leasing_company/core/presentation/widgets/custom_dropdown.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_field.dart';
import 'package:leasing_company/core/presentation/widgets/missing_articles_and_can_create.dart';
import 'package:leasing_company/core/presentation/widgets/missing_articles_and_can_not_create.dart';
import 'package:leasing_company/features/articles/domain/entities/article_mini_entity.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_mini_entity.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_priority.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/bloc/create_edit_task_page_bloc.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/widgets/label_text.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';

class CreateEditTaskPage extends StatelessWidget {
  final int? taskId;
  final Article? article;
  final ScrollController _scrollController = ScrollController();
  final _toastService = getIt<ToastService>();

  CreateEditTaskPage({Key? key, this.taskId, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateEditTaskPageBloc>(
      create: (context) {
        final bloc = CreateEditTaskPageBloc(taskId, article);
        bloc.add(InitEvent());
        return bloc;
      },
      child: WillPopScope(
        onWillPop: () async {
          //todo show popup if data was changed
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Navigator.of(context).canPop()
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : SizedBox.shrink(),
            title: Text(
              taskId == null
                  ? S.of(context).addingTask
                  : S.of(context).editingTask,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: BlocBuilder<CreateEditTaskPageBloc, CreateEditTaskPageState>(
              builder: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (state.needPop) {
                Navigator.pop(context);
                _toastService.showSuccessToast(
                  context,
                  S.of(context).taskCreatedSuccessfully,
                );
              }
            });

            // нет объектов и происходит создание
            if (state.hasArticles == false && taskId == null) {
              return state.currentCompany?.config.canCreateArticles == true
                  ? MissingArticlesAndCanCreateWidget()
                  : MissingArticlesAndCanNotCreateWidget();
            }

            if (state.listReviewTemplates != null || state.selectedReviewTemplate != null) {
              return SingleChildScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelTextWidget(
                      text: S.of(context).taskType,
                      isRequired: true,
                    ),
                    CustomDropdownWidget<ReviewTemplateMiniEntity>(
                      items: taskId == null ? state.listReviewTemplates! : [state.selectedReviewTemplate!],
                      isValid: state.selectedReviewTemplate != null || state.isNeedHideValidateResults,
                      initialValue: state.selectedReviewTemplate,
                      hintText: S.of(context).pickTaskType,
                      emptyText: S.of(context).haveNoTaskTypesAvailable,
                      isRequiredField: true,
                      isEnable: taskId == null,
                      toDropdownItemText: (item) {
                        return (item as ReviewTemplateMiniEntity).name;
                      },
                      onChanged: (value) {
                        context.read<CreateEditTaskPageBloc>().add(ReviewTemplateChangedEvent(value));
                      },
                    ),
                    LabelTextWidget(
                      text: S.of(context).object,
                      isRequired: true,
                    ),
                    CustomDropdownWidget<ArticleMiniEntity>(
                      isValid: state.selectedArticle != null || state.isNeedHideValidateResults,
                      key: UniqueKey(),
                      items: taskId == null && article == null ? state.listArticles : [state.selectedArticle!],
                      hintText: S.of(context).pickObject,
                      emptyText: S.of(context).haveNoArticlesAvailable,
                      initialValue: state.selectedArticle,
                      isRequiredField: true,
                      isEnable: state.selectedReviewTemplate != null && taskId == null && article == null,
                      toDropdownItemText: (item) {
                        return (item as ArticleMiniEntity).title;
                      },
                      onChanged: (value) {
                        context.read<CreateEditTaskPageBloc>().add(ArticleChangedEvent(value));
                      },
                    ),
                    LabelTextWidget(
                      text: S.of(context).taskAddress,
                      isRequired: false,
                    ),
                    CustomTextField(
                      hintText: S.of(context).enterObjectAddress,
                      initialValue: state.address,
                      onChanged: (String newAddress) {
                        state.address = newAddress;
                      },
                    ),
                    LabelTextWidget(
                      text: S.of(context).startOfExecution,
                      isRequired: false,
                    ),
                    CustomDatePickerWidget(
                      initialDate: state.startExecutionAt,
                      onDateChanged: (DateTime newDate) {
                        state.startExecutionAt = newDate;
                        context.read<CreateEditTaskPageBloc>().add(UpdateUiEvent());
                      },
                    ),
                    LabelTextWidget(
                      text: S.of(context).deadline,
                      isRequired: false,
                    ),
                    CustomDatePickerWidget(
                      initialDate: state.finishExecutionAt,
                      onDateChanged: (DateTime date) {
                        state.finishExecutionAt = date;
                        context.read<CreateEditTaskPageBloc>().add(UpdateUiEvent());
                      },
                    ),
                    LabelTextWidget(
                      text: S.of(context).priority,
                      isRequired: false,
                    ),
                    CustomDropdownWidget<TaskPriority>(
                      hintText: S.of(context).pickPriority,
                      items: TaskPriority.values,
                      initialValue: state.priority,
                      isRequiredField: false,
                      toDropdownItemText: (item) {
                        return (item as TaskPriority).getWithLocalization(context);
                      },
                      onChanged: (value) {
                        context.read<CreateEditTaskPageBloc>().add(PriorityChangedEvent(value));
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabelTextWidget(text: S.of(context).sendForApproval, isRequired: false),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Transform.scale(
                              scale: 0.85,
                              child: CupertinoSwitch(
                                  activeColor: Color(0xFF246BFD),
                                  value: state.isNeedSendToApproval,
                                  onChanged: (_) {
                                    context.read<CreateEditTaskPageBloc>().add(NeedSendForApprovalValueChangedEvent());
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        if (state.isButtonActive) {
                          final bloc = context.read<CreateEditTaskPageBloc>();
                          if (bloc.state.selectedReviewTemplate != null && bloc.state.selectedArticle != null) {
                            context.read<CreateEditTaskPageBloc>().add(SaveButtonPressedEvent(reviewOrTaskTitle:state.selectedReviewTemplate!.name , objectTitle: state.selectedArticle!.title));
                          } else {
                            context.read<CreateEditTaskPageBloc>().add(ShowValidateResults());
                            _scrollController.animateTo(
                              0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          }
                        }
                      },
                      child: Ink(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color(0xFF246BFD)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: state.isButtonActive
                                ? Text(
                                    taskId == null ? S.of(context).create : S.of(context).save,
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                                  )
                                : SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
        ),
      ),
    );
  }
}
