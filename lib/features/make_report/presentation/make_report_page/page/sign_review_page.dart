import 'package:flutter/material.dart';
import 'package:leasing_company/core/presentation/widgets/linked_check_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/generated/l10n.dart';

class SignReviewPage extends StatelessWidget {
  final String? pdfFile;

  const SignReviewPage({
    this.pdfFile,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<MakeReportBloc>().add(MakeReportRefreshEvent());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Text(
                    S.of(context).signReviewTitle,
                    style: TextStyle(fontSize: 24, fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600, height: 1.3),
                  ),
                  SizedBox(height: 20),
                  Text(
                    S.of(context).signReviewDescription,
                    style: TextStyle(fontSize: 18, fontFamily: 'SF Pro Display', fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              LinkedCheckBox(
                pdfLink: pdfFile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
