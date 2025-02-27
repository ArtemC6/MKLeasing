import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/make_report_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/report_preview_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/bloc/review_list_bloc.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_model.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_status.dart';

class ReviewItemWidget extends StatelessWidget {
  final ReviewModel reviewModel;
  final CompanyEntity companyEntity;
  final int index;
  final ReviewStatus? status;

  ReviewItemWidget({required this.reviewModel, required this.companyEntity, required this.index, this.status});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: Color(0xffE1E1E1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.08),
              offset: const Offset(0, 3),
              blurRadius: 6,
            ),
            BoxShadow(color: Colors.white), //BoxShadow
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => status == ReviewStatus.scheduled
                    ? ReportPreviewPage(
                        company: companyEntity,
                        article: reviewModel.article,
                        template: ReviewTemplateModel.fromDBModel(reviewModel),
                        review: reviewModel.review,
                        isOpenedFromReviews: true,
                        index: index)
                    : MakeReportPage(
                        company: companyEntity,
                        article: reviewModel.article,
                        template: ReviewTemplateModel.fromDBModel(reviewModel),
                        review: reviewModel.review,
                        isOpenedFromReviews: true,
                        index: index,
                      ),
              ),
            );
            context.read<ReviewListBloc>().add(InitialEvent());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Container(
                constraints: BoxConstraints(minHeight: 84),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 28),
                      width: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                        ),
                        color: reviewModel.status.statusColor(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 26),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviewModel.name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.start,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                reviewModel.article.title,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                reviewModel.status.name(context),
                                softWrap: true,
                                style: TextStyle(
                                  color: reviewModel.status.statusColor(),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
