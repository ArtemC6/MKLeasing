import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:hive/hive.dart';
import 'package:leasing_company/api/data_service.dart';
import 'package:leasing_company/core/presentation/widgets/on_center_widget.dart';
import 'package:leasing_company/features/help/presentation/help/bloc/help_bloc.dart';
import 'package:leasing_company/features/help/presentation/help/bloc/help_event.dart';
import 'package:leasing_company/features/help/presentation/help/bloc/help_state.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_export_service.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final ToastService toastService = getIt<ToastService>();
  String userDeviceUdid = '';

  @override
  Widget build(BuildContext context) {
    FlutterUdid.udid.then((value) => userDeviceUdid = value);
    return BlocProvider<HelpBloc>(
      create: (context) => HelpBloc(),
      child: BlocConsumer<HelpBloc, HelpState>(listener: (context, state) {
        if (state is HelpClearState) {
          toastService.showSuccessToast(
              context,
              S.of(context).helpScreenClearedMemoryToast(
                  (state.clearedBytes / 1024 / 1024).round()));
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(elevation: 0),
          body: BlocBuilder<HelpBloc, HelpState>(
            builder: (context, state) {
              if (state is HelpNeedToChooseCompanyState) {
                return Text(S.of(context).helpScreenNeedToChooseCompany);
              } else if (state is HelpLoadInProgressState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HelpReadyState) {
                List<Widget> components = [];

                components.add(Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: MediaQuery.of(context).size.height * 0.2,
                ));

                components.add(Padding(padding: EdgeInsets.only(top: 70)));

                if (state.hasHelpQuestions) {
                  components.add(
                    buttonWidget(S.of(context).helpScreenQuestionsAndAnswers,
                        onPressed: () =>
                            Navigator.pushNamed(context, '/help/questions')),
                  );
                }

                if (state.company.config.email != null)
                  components.add(
                    buttonWidget(S.of(context).helpScreenWriteEmail,
                        onPressed: () async => await launchUrlString(
                            "mailto:${state.company.config.email}")),
                  );

                if (state.company.config.phone != null)
                  components.add(
                    buttonWidget(S.of(context).helpScreenCallUs,
                        onPressed: () async => await launchUrlString(
                            "tel:${state.company.config.phone}")),
                  );

                if (state.hasFilesForExport) {
                  components.add(
                    buttonWidget(
                      S.of(context).helpScreenExportFilesButtonTitle,
                      onPressed: () => BlocProvider.of<HelpBloc>(context)
                          .add(HelpExportFilesFromStorageEvent()),
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.fromLTRB(22.5, 22.5, 22.5, 0),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: components,
                        ),
                        Spacer(),
                        deleteAccountButton(context),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            'V: ${getIt<PackageInfo>().buildNumber}\nID: $userDeviceUdid',
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is HelpExportFilesFromStorageState) {
                return Container(
                  padding: EdgeInsets.all(15.0),
                  child: StreamBuilder(
                    stream: state.exportProgress.asBroadcastStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text((snapshot.data as ExportProgress)
                                      .description +
                                  '\n'),
                              LinearProgressIndicator(
                                value:
                                    (snapshot.data as ExportProgress).progress /
                                        100,
                              ),
                            ]);
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        BlocProvider.of<HelpBloc>(context)
                            .add(HelpReadyEvent());
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
                          ],
                        );
                      }
                    },
                  ),
                );
              } else {
                return Scaffold(
                  body: OnCenterWidget(
                      message: S.of(context).unexpectedException),
                );
              }
            },
          ),
        );
      }),
    );
  }

  Widget buttonWidget(
    String title, {
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.transparent, width: 0),
            padding: EdgeInsets.all(16),
            foregroundColor: Colors.white,
            backgroundColor: Color(0xffE9F0FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            )),
        child: Text(
          title,
          style: TextStyle(
              color: Color(0xff246BFD),
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget deleteAccountButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.transparent, width: 1.5),
          padding: EdgeInsets.all(16),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFFF3F3F3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Text(
          S.of(context).logOutAndDeleteYourAccount,
          style: TextStyle(
              color: Color(0xFFFF4343),
              fontSize: 16,
              fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: () async {
          final isDeleteConfirmed = await showDeleteConfirmationDialog(context);

          if(isDeleteConfirmed) {
            await getIt<DataService>().clear();

            final appBox = getIt.get<Box>(instanceName: 'AppBox');
            appBox.put('accessToken', null);

            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (_) => false);
          }
        },
      ),
    );
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return true ==
        await showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Text(
              S.of(context).confirmTheAction,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: Text(
              S.of(context).deleteAccountDialogDescription,
              textAlign: TextAlign.start,
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 22.0, right: 5, left: 15),
                      child: GestureDetector(
                        onTap: () => Navigator.of(dialogContext).pop(false),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF4242),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            S.of(context).makeReportPageCancel,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 22.0, left: 5, right: 15),
                      child: GestureDetector(
                        onTap: () => Navigator.of(dialogContext).pop(true),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Color(0xFFFF4242), width: 2),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            S.of(context).confirm,
                            style: TextStyle(
                              color: Color(0xFFFF4242),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
  }
}
