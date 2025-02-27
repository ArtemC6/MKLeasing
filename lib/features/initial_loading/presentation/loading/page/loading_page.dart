import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/app.dart';
import 'package:leasing_company/features/initial_loading/presentation/loading/bloc/loading_bloc.dart';
import 'package:leasing_company/features/initial_loading/presentation/loading/bloc/loading_event.dart';
import 'package:leasing_company/features/initial_loading/presentation/loading/bloc/loading_state.dart';
import 'package:leasing_company/features/initial_loading/presentation/loading/page/error_page.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_export_service.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final ToastService _toastService = getIt();
  Completer<void> _refreshCompleter = Completer<void>();

  statusWidget(String description) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: CircularProgressIndicator(),
              ),
              Text(description, textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }

  showUpdateDialog(BuildContext context, VersionStatus versionStatus) {
    String dialogText = S.of(context).loadingScreenHasNewUpdate(
        versionStatus.localVersion, versionStatus.storeVersion);

    if (versionStatus.releaseNotes != null) {
      dialogText += S
          .of(context)
          .loadingScreenUpdateHasNotes(versionStatus.releaseNotes!);
    }

    newVersion.showUpdateDialog(
      context: context,
      versionStatus: versionStatus,
      dialogTitle: S.of(context).loadingScreenUpdateDialogTitle,
      dialogText: dialogText,
      updateButtonText:
          S.of(context).loadingScreenUpdateDialogUpdateButtonTitle,
      dismissButtonText:
          S.of(context).loadingScreenUpdateDialogDismissButtonTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadingBloc, LoadingState>(
      listener: (context, state) {
        if (state is LoadingReloadingTasksState) {
          if (state.finish && state.count > 0) {
            _toastService.showSuccessToast(context,
                S.of(context).loadingScreenUploadingFilesStarted(state.count));
          }
        }
        if (state is LoadingAuthenticatedState) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        if (state is LoadingUnauthenticatedState) {
          Navigator.pushReplacementNamed(context, '/login');
        }
        if ((!kDebugMode || !Platform.isAndroid) &&
            (state is LoadingAuthenticatedState ||
                state is LoadingUnauthenticatedState ||
                state is LoadingVersionFailureState ||
                state is LoadingFailureState)) {
          newVersion.getVersionStatus().then((value) {
            if (value?.canUpdate == true) {
              showUpdateDialog(App.navigatorKey.currentContext!, value!);
            }
          });
        }
      },
      builder: (context, state) {
        return RefreshIndicator(onRefresh: () {
          BlocProvider.of<LoadingBloc>(context)
              .add(LoadingRefreshEvent(_refreshCompleter));
          return _refreshCompleter.future;
        }, child: BlocBuilder<LoadingBloc, LoadingState>(
          builder: (context, state) {
            if (state is LoadingInProgressState) {
              return statusWidget(S.of(context).loadingScreenLoadingAppTitle);
            }
            if (state is LoadingVersionFailureState) {
              return Scaffold(
                  body: Container(
                padding: EdgeInsets.all(10),
                child: ListView(children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(35.0),
                      child: Column(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/logo.png'),
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: S
                                      .of(context)
                                      .loadingScreenHasNewUpdateText1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: S
                                      .of(context)
                                      .loadingScreenHasNewUpdateText2,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                TextSpan(
                                  text: S
                                      .of(context)
                                      .loadingScreenHasNewUpdateText3,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async => await launchUrlString(
                                        Api.baseUrl + "/install",
                                        mode: LaunchMode.externalApplication),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ]),
              ));
            }
            if (state is LoadingFailureState) {
              return ErrorPage(
                platformInfo: state.platformInfo,
                hasFilesForExport: state.hasFilesForExport,
                description: state.description,
                errorMessage: state.errorMessage,
                onTryAgain: () {
                  context.read<LoadingBloc>().add(LoadingAppStartEvent());
                },
              );
            }
            if (state is LoadingRefreshState) {
              return statusWidget(S.of(context).loadingScreenRetrying);
            }
            if (state is LoadingOfflineState) {
              return statusWidget(
                  S.of(context).loadingScreenStartingOfflineMode);
            }
            if (state is LoadingUnauthenticatedState ||
                state is LoadingAuthenticatedState) {
              return statusWidget(
                  S.of(context).loadingScreenConnectingToServer);
            }
            if (state is LoadingReloadingTasksState) {
              return statusWidget(!state.finish
                  ? S
                      .of(context)
                      .loadingScreenRetryingSending(state.progress, state.count)
                  : '');
            }
            if (state is LoadingExportFilesFromStorageState) {
              return Scaffold(
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: StreamBuilder(
                          stream: state.exportProgress.asBroadcastStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text((snapshot.data as ExportProgress)
                                            .description +
                                        '\n'),
                                    LinearProgressIndicator(
                                      value: (snapshot.data as ExportProgress)
                                              .progress /
                                          100,
                                    ),
                                  ]);
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              BlocProvider.of<LoadingBloc>(context)
                                  .add(LoadingAppStartEvent());
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ]);
                            } else {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ]);
                            }
                          })),
                ),
              );
            }
            return statusWidget(S.of(context).unexpectedException);
          },
        ));
      },
    );
  }
}
