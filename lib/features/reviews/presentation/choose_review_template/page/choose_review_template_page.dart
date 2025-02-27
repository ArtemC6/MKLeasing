import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/missing_and_can_not_create.dart';
import 'package:leasing_company/core/presentation/widgets/on_center_widget.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/make_report_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/report_preview_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_proxy.dart';
import 'package:leasing_company/features/reviews/presentation/choose_review_template/bloc/choose_review_template_bloc.dart';
import 'package:leasing_company/features/reviews/presentation/choose_review_template/bloc/choose_review_template_state.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';

class ChooseReviewTemplatePage extends StatefulWidget {
  final Article article;

  ChooseReviewTemplatePage({required this.article});

  @override
  State<StatefulWidget> createState() => _ChooseReviewTemplatePageState();
}

class _ChooseReviewTemplatePageState extends State<ChooseReviewTemplatePage>
    with WidgetsBindingObserver {
  final ToastService toastService = getIt();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseReviewTemplateBloc(article: widget.article),
      child: BlocConsumer<ChooseReviewTemplateBloc, ChooseReviewTemplateState>(
        listener: (context, state) {
          if (state is ChooseReviewTemplateLoadFailureState) {
            toastService.showFailureToast(
                context, S.of(context).chooseReviwTemplateInternetException);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                S.of(context).chooseReviwTemplate,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
            ),
            body: BlocBuilder<ChooseReviewTemplateBloc,
                ChooseReviewTemplateState>(
              builder: (context, state) {
                if (state is ChooseReviewTemplateLoadInProgressState) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is ChooseReviewTemplateLoadSuccessState) {
                  if (state.articleTemplatesProxies.isNotEmpty) {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: 6, bottom: 30),
                        itemCount: state.articleTemplatesProxies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _makeReviewTemplateRow(
                            state.articleTemplatesProxies[index],
                            context,
                            state.company,
                          );
                        });
                  } else {
                    return MissingAndCanNotCreateWidget(
                      missingItemsName: S.of(context).missingReviewsName,
                    );
                  }
                }
                return OnCenterWidget(
                    message: S.of(context).chooseReviewTemplateNoInternet);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _makeReviewTemplateRow(
    ReviewTemplateProxy articleTemplateProxy,
    BuildContext context,
    CompanyEntity company,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 12),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => articleTemplateProxy.template.private == true &&
                      articleTemplateProxy.review == null
                  ? ReportPreviewPage(
                      company: company,
                      article: widget.article,
                      template: articleTemplateProxy.template,
                      review: articleTemplateProxy.review,
                    )
                  : MakeReportPage(
                      company: company,
                      article: widget.article,
                      template: articleTemplateProxy.template,
                      review: articleTemplateProxy.review,
                    ),
            ),
          );
            Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xffF0F0F0),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(4, 6, 15, 0.08),
                spreadRadius: 0,
                blurRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        articleTemplateProxy.template.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(height: 6),
                      articleTemplateProxy.template.private == true &&
                              articleTemplateProxy.review == null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.error,
                                    color: Color(0xFFF75555), size: 16),
                                SizedBox(width: 6),
                                Text(
                                  S
                                      .of(context)
                                      .chooseReviewTemplateScreenAwaitForContinue,
                                  style: TextStyle(
                                      color: Color(0xFFF75555), fontSize: 12),
                                ),
                              ],
                            )
                          : Text(
                              articleTemplateProxy.review != null
                                  ? S
                                      .of(context)
                                      .chooseReviwTemplateScreenContinueReview
                                  : S
                                      .of(context)
                                      .chooseReviewTemplateScreenAvailable,
                              style: TextStyle(
                                fontSize: 12,
                                color: articleTemplateProxy.review != null
                                    ? Color(0xFFF75555)
                                    : Color(0xFF246BFD),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.fromLTRB(9, 8, 8, 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF246BFD).withOpacity(0.06),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color(0xFF246BFD),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
