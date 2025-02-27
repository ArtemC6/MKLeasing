import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkedCheckBox extends StatefulWidget {
  final bool initialValue;
  final String? pdfLink;

  const LinkedCheckBox({
    Key? key,
    this.initialValue = false,
    this.pdfLink,
  }) : super(key: key);

  @override
  State<LinkedCheckBox> createState() => _LinkedCheckBoxState();
}

class _LinkedCheckBoxState extends State<LinkedCheckBox> {
  bool isCheckboxOn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCheckboxOn = !isCheckboxOn;
                  });
                },
                child: AnimatedContainer(
                  height: 24,
                  width: 24,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isCheckboxOn ? Color(0xFF246BFD) : Colors.transparent,
                    border: Border.all(color: Color(0xFF246BFD), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: isCheckboxOn ? Colors.white : Colors.transparent,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      text: S.of(context).linkedCheckBoxPrivacyAgreementFirst,
                      style: TextStyle(fontSize: 16, color: Color(0xFF212121), fontFamily: 'SF Pro Display'),
                      children: <TextSpan>[
                        TextSpan(
                          text: S.of(context).linkedCheckBoxPrivacyAgreementSecond,
                          style: TextStyle(
                            color: Color(0xFF246BFD),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchPDF();
                            },
                        ),
                        TextSpan(
                          text: S.of(context).linkedCheckBoxPrivacyAgreementThird,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            width: double.infinity,
            child: CustomOutlinedButton(
              verticalPadding: 11,
              text: S.of(context).linkedCheckBoxSendButton,
              backgroundColor: isCheckboxOn ? Color(0xff246BFD) : Color(0xff476EBE),
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              onPressed: () async {
                if (isCheckboxOn) {
                  context.read<MakeReportBloc>().add(MakeReportFinishEvent(true));
                  var connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult == ConnectivityResult.none) {
                    print('Нет подключения к интернету');
                    Navigator.of(context).pop();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => true);
                  }
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            width: double.infinity,
            child: CustomOutlinedButton(
              backgroundColor: Color(0xFFFDFDFD),
              foregroundColor: Color(0xff246BFD),
              borderColor: Color(0xff246BFD),
              verticalPadding: 11,
              text: S.of(context).linkedCheckBoxCancelButton,
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              onPressed: () async {
                context.read<MakeReportBloc>().add(MakeReportRefreshEvent());
              },
            ),
          ),
        ],
      ),
    );
  }

  _launchPDF() async {
    String url = widget.pdfLink ?? '';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: Platform.isAndroid ? LaunchMode.externalNonBrowserApplication : LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }
}
