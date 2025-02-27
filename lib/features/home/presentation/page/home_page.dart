import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/core/presentation/widgets/no_link_to_company_widget.dart';
import 'package:leasing_company/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:leasing_company/features/home/presentation/bottom_nav_bar_items.dart';
import 'package:leasing_company/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:leasing_company/features/home/presentation/widgets/menu_add_widget.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/bloc/review_list_bloc.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_model.dart';
import 'package:leasing_company/main.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = ReviewListBloc();
  final DialogManager _dialogManager = getIt();

  @override
  void initState() {
    _bloc.add(InitialEvent());
    super.initState();
  }

  _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomePageChooseCompanyState) {
          return Scaffold(body: NoLinkToCompanyWidget());
        }
        if (state is HomePageReadyState) {
          return BlocProvider.value(
            value: _bloc,
            child: BlocListener<ReviewListBloc, ReviewListState>(
              bloc: _bloc,
              listener: (context, reviewState) async {
                if (reviewState is ReviewsLoadSuccessState && !_isThereCurrentDialogShowing(context)) {
                  // _bloc.add(InitialEvent());

                  _bloc.getModals().then((value) async {
                    await Future.forEach(value.keys, (key) async {
                      if (value[key] != null && (key as InfoModal).enable) {
                        await Future.forEach(value[key]!.toList(), (ReviewModel element) async {
                          if (!element.isOpened)
                            await _dialogManager.showScheduledReviewInfoDialog(
                              context,
                              key,
                              element,
                              state.company,
                            );
                        });
                      }
                    });
                  });
                }
              },
              child: Scaffold(
                body: SafeArea(
                  child: Stack(
                    children: [
                      Modules.values[state.actualPageIndex].getScreen(),
                      AnimatedOpacity(
                        opacity: state.isAddButtonPressed ? 1 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Visibility(
                          visible: state.isAddButtonPressed,
                          child: GestureDetector(
                            onTap: () {
                              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                statusBarColor: state.isAddButtonPressed ? Colors.white : Colors.grey,
                                statusBarIconBrightness: state.isAddButtonPressed ? Brightness.dark : Brightness.light,
                                systemNavigationBarColor: state.isAddButtonPressed ? Colors.white : Colors.grey,
                              ));
                              context.read<HomePageBloc>().add(AddButtonPressedEvent());
                            },
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedOpacity(
                          opacity: state.isAddButtonPressed ? 1 : 0,
                          duration: Duration(milliseconds: 300),
                          child: Visibility(
                            visible: state.isAddButtonPressed,
                            child: MenuAddWidget(
                              state.company,
                              state: state,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavBarWidget(initialPageIndex: 0),
              ),
            ),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
