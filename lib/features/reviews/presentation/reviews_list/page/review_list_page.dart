import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/presentation/widgets/custom_search_widget.dart';
import 'package:leasing_company/core/presentation/widgets/missing_and_can_create.dart';
import 'package:leasing_company/features/make_report/presentation/create_review_page/page/create_review_page.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/bloc/review_list_bloc.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_status.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/widgets/review_item_status.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/widgets/review_item_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

class ReviewListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  late final ReviewListBloc _bloc;
  ReviewStatus? reviewStatus;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewListBloc>(
      create: (context) {
        _bloc = ReviewListBloc();
        _bloc.add(InitialEvent());

        return _bloc;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    _bloc.add(SearchShowingModeChangedEvent());
                  },
                  splashColor: Colors.black.withOpacity(0.05),
                  highlightColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: Color(0xFF005AEA),
                    fit: BoxFit.scaleDown,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
            title: Text(
              S.of(context).reviews,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: SvgPicture.asset(
              'assets/icons/checks.svg',
              color: Colors.black,
              fit: BoxFit.scaleDown,
              width: 28,
              height: 28,
            ),
          ),
          body: BlocConsumer<ReviewListBloc, ReviewListState>(
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case ReviewsLoadSuccessState:
                  return buildListReviews(
                    state as ReviewsLoadSuccessState,
                    context,
                  );
                case ReviewsInitialState:
                  return Center(child: CircularProgressIndicator());
                case ReviewsNeedToChooseCompanyState:
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        S.of(context).articlesScreenNeedToChooseCompany,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                case ReviewsLoadFailureState:
                  return Container();
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildListReviews(ReviewsLoadSuccessState state, BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: 50),
          padding: const EdgeInsets.only(bottom: 8, top: 6),
          margin: const EdgeInsets.only(bottom: 1),
          color: Color(0xFFFDFDFD),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: BouncingScrollPhysics(),
            children: ReviewStatus.values
                .map((status) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: BuildFilterItem(
                        text: status.name(context),
                        isEnable: reviewStatus == status,
                        color: status.statusColor(),
                        onTap: (isEnable) {
                          reviewStatus = isEnable ? status : null;
                          _bloc.add(FilterChangedEvent(reviewStatus));
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
        if (state.isSearchShowing)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xFFEEEEEE),
            ),
            child: CustomSearchWidget(
              initialValue: state.searchText,
              onChanged: (searchText) {
                _bloc.add(SearchTextChangedEvent(searchText));
              },
            ),
          ),
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  final completer = Completer();
                  _bloc.add(InitialEvent(completer: completer));
                  return completer.future;
                },
                child: state.reviews.isNotEmpty
                    ? ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemCount: state.reviews.length,
                        padding: EdgeInsets.only(top: 8, bottom: 40),
                        itemBuilder: (BuildContext context, int index) {
                          return ReviewItemWidget(
                            reviewModel: state.reviews[index],
                            companyEntity: state.companyEntity,
                            index: index,
                            status: state.reviews[index].status,
                          );
                        },
                      )
                    : Stack(
                        children: [
                          ListView(
                            physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics(),
                            ),
                          ),
                          context.read<ReviewListBloc>().reviewList.isEmpty
                              ? MissingAndCanCreateWidget(
                                  missingItemsName: S.of(context).reviews,
                                  description: S.of(context).waitForTheirAppointmentOr,
                                  onCreateButtonTap: () async {
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CreateReviewPage(),
                                      ),
                                    );
                                    _bloc.add(InitialEvent());
                                  },
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 30,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.searchText.isEmpty
                                          ? state.filterIndex == 0
                                              ? S.of(context).noChecksScheduledOrStarted
                                              : state.filterIndex == 1
                                                  ? S.of(context).noStartedChecks
                                                  : state.filterIndex == 2
                                                      ? S.of(context).noScheduledChecks
                                                      : S.of(context).noInReworkChecks
                                          : S.of(context).checksWithThisNameNotFound,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
              ),
              Container(
                height: 1.5,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
