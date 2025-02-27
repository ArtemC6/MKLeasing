import 'package:flutter/material.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/generated/l10n.dart';

class StepSkippedWidget extends StatelessWidget {
  final ReviewStepFile stepFile;

  const StepSkippedWidget({
    Key? key,
    required this.stepFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.only(left: 4.0, bottom: 4.0, right: 4.0),
      color: Colors.black,
      child: new Stack(
        children: <Widget>[
          Center(
            child: Text(
              S.of(context).makeReportPageMissedWithComments(
                    stepFile.comment.toString(),
                  ),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
