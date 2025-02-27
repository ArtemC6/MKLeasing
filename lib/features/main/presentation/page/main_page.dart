import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/presentation/widgets/custom_radiobutton_group.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/help/presentation/help/page/help_page.dart';
import 'package:leasing_company/features/main/presentation/bloc/main_page_bloc.dart';
import 'package:leasing_company/features/main/presentation/widgets/notification_item_widget.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/push_messaging_service.dart';

final _numberDisplayedNotifications = 2;


class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainPageBloc _bloc;
  late final StreamSubscription<RemoteMessage> pushMessagingStreamSubscription;
  Completer refreshCompleter = Completer();

  @override
  void initState() {
    super.initState();
    final pushMessagingService = getIt<PushMessagingService>();
    pushMessagingStreamSubscription =
        pushMessagingService.controller.stream.listen(
      (event) => _bloc.add(InitialEvent()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pushMessagingStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainPageBloc>(
      create: (context) {
        _bloc = MainPageBloc();
        _bloc.add(InitialEvent());
        return _bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          leading: SvgPicture.asset(
            'assets/icons/home.svg',
            color: Colors.black,
            fit: BoxFit.scaleDown,
            width: 30,
            height: 30,
          ),
          title: Text(
            S.of(context).main,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HelpPage()));
                },
                splashColor: Colors.black.withOpacity(0.05),
                highlightColor: Colors.transparent,
                icon: Icon(
                  Icons.help_outline,
                  color: Color(0xFF246BFD),
                  size: 26,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<MainPageBloc, MainPageState>(
          builder: (context, state) {
            return state.companiesList != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.companiesList != null) ...[
                        SizedBox(height: 16),
                        state.selectedCompany != null &&
                                state.companiesList!.isNotEmpty
                            ? state.companiesList!.length > 1
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S.of(context).accountSelection,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          CustomRadioButtonsGroup<
                                              CompanyEntity>(
                                            items: state.companiesList!,
                                            onSelected: (value, _, __) {
                                              _bloc.add(
                                                ChangedCompanyEvent(value),
                                              );
                                            },
                                            getTitle: (value) => value.name,
                                            itemStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            selectedItemIndex:
                                                state.companiesList!.indexOf(
                                                    state.selectedCompany!),
                                          ),
                                        ]),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                      right: 16,
                                      bottom: 6,
                                    ),
                                    child: Text(
                                      state.selectedCompany!.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                            : SizedBox.shrink(),
                      ],
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              S.of(context).notificationsScreenTitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _bloc.add(ChangeDisplayNotificationModeEvent());
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Text(
                                state.isShowAllNotifications
                                    ? S.of(context).hide
                                    : S.of(context).showAll,
                                style: TextStyle(
                                  color: Color(0xFF246BFD),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _bloc.add(
                              RefreshNotificationsListEvent(refreshCompleter),
                            );
                            await refreshCompleter.future;
                            refreshCompleter = Completer();
                          },
                          child: state.notifications != null &&
                                  !state.isHaveExceptions &&
                                  state.notifications!.isNotEmpty
                              ? ListView.builder(
                                  padding: EdgeInsets.only(top: 4, bottom: 30),
                                  physics: AlwaysScrollableScrollPhysics()
                                      .applyTo(BouncingScrollPhysics()),
                                  itemCount: state.isShowAllNotifications
                                      ? state.notifications!.length
                                      : state.notifications!.length >=
                                              _numberDisplayedNotifications
                                          ? _numberDisplayedNotifications
                                          : state.notifications!.length,
                                  itemBuilder: (context, index) {
                                    return NotificationItem(
                                      state.notifications![index],
                                    );
                                  },
                                )
                              : Stack(
                                  children: [
                                    ListView(
                                      physics: AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics(),
                                      ),
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size.height / 2,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 30),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          state.isHaveExceptions
                                              ? S.of(context)
                                                  .noInternetConnectionNotifications
                                              : S.of(context)
                                                  .notificationsScreenYetHaveNotNotifications,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
