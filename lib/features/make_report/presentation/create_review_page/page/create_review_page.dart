import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_dropdown.dart';
import 'package:leasing_company/core/presentation/widgets/missing_articles_and_can_create.dart';
import 'package:leasing_company/core/presentation/widgets/missing_articles_and_can_not_create.dart';
import 'package:leasing_company/features/make_report/presentation/create_review_page/bloc/create_review_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/make_report_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/widgets/label_text.dart';
import 'package:leasing_company/generated/l10n.dart';

class CreateReviewPage extends StatelessWidget {
  CreateReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateReviewBloc>(
      create: (ctx) {
        final bloc = CreateReviewBloc();
        bloc.add(InitialEvent(S.of(context)));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
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
            S.of(context).uploadsScreenEntiyActionReviewStoreTitle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        body: BlocBuilder<CreateReviewBloc, CreateReviewState>(builder: (context, state) {
          if (state.listArticles == null && state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 20.0),
              ),
            );
          }

          if (state.listArticles != null && state.listArticles!.length == 0) {
            return state.currentCompany?.config.canCreateArticles == true
                ? MissingArticlesAndCanCreateWidget()
                : MissingArticlesAndCanNotCreateWidget();
          }

          if (state.listArticles != null && state.listArticles!.length > 0) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  LabelTextWidget(
                    text: S.of(context).object,
                    isRequired: true,
                  ),
                  CustomDropdownWidget<Article>(
                    isValid: state.selectedArticle != null || state.isNeedHideValidateResults,
                    key: UniqueKey(),
                    items: state.listArticles,
                    hintText: S.of(context).pickObject,
                    initialValue: state.selectedArticle,
                    isRequiredField: true,
                    itemHeight: null,
                    toDropdownItemText: (item) {
                      return (item as Article).title;
                    },
                    onChanged: (article) {
                      context.read<CreateReviewBloc>().add(ArticleChangedEvent(article));
                    },
                  ),
                  SizedBox(height: 4),
                  LabelTextWidget(
                    text: S.of(context).reviewTemplate,
                    isRequired: true,
                  ),
                  CustomDropdownWidget<ReviewTemplate>(
                    items: state.listReviewTemplates,
                    isValid: state.selectedReviewTemplate != null || state.isNeedHideValidateResults,
                    initialValue: state.selectedReviewTemplate,
                    hintText: S.of(context).chooseReviwTemplate,
                    emptyText: S.of(context).haveNoTemplatesAvailable,
                    isRequiredField: true,
                    isEnable: state.selectedArticle != null,
                    itemHeight: null,
                    toDropdownItemText: (item) => (item as ReviewTemplate).name,
                    onChanged: (value) {
                      context.read<CreateReviewBloc>().add(ReviewTemplateChangedEvent(value));
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      final bloc = context.read<CreateReviewBloc>();
                      if (state.selectedReviewTemplate != null && state.selectedArticle != null && state.currentCompany != null) {
                        bloc.add(OnCreatedReviewEvent(articleTitle: state.selectedArticle!.title, templateTitle: state.selectedReviewTemplate!.name));
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MakeReportPage(
                              company: state.currentCompany!,
                              article: state.selectedArticle!,
                              template: ReviewTemplateModel.fromDBModel(state.selectedReviewTemplate!),
                            ),
                          ),
                        );

                        if (result == 'pop') {
                          Navigator.pop(context);
                        }
                      } else {
                        final bloc = context.read<CreateReviewBloc>();
                        bloc.add(ShowValidateResultsEvent());
                      }
                    },
                    child: Ink(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color(0xFF246BFD)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            S.of(context).create,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
