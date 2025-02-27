import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';

class ContentItemWidget extends StatelessWidget {
  final ReviewTemplateStepModel step;
  final ReviewStepFile stepFile;
  final List<ReviewStepFile> stepFilesList;
  final int index;
  final StepContentType stepContentType;

  ContentItemWidget({
    Key? key,
    required this.stepFile,
    required this.stepFilesList,
    required this.index,
    required this.step,
    required this.stepContentType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          stepContentType.onMediaPreviewTap(stepFile, stepFilesList, context),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 0.5,
            offset: Offset(0, 1),
          ),
        ], borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Stack(children: [
          ...stepContentType.previewContent(stepFile),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  context.read<MakeReportBloc>()
                      .add(MakeReportDeleteFileEvent(stepFile));
                  },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        spreadRadius: 0.7,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.clear,
                    size: 16,
                    color: Color(0xFFC07777),
                  ),
                ),
              ),
            ),
          ),
          if (stepContentType != StepContentType.file &&
              stepContentType != StepContentType.audio)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        spreadRadius: 0.7,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/edit.svg',
                    height: 15,
                    width: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.lightBlueAccent,
                  Colors.blue,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Text(
              index.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
