import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_item_widget.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:path/path.dart';

class ContentPreviewWidget extends StatelessWidget {
  final MakeReportBloc makeReportBloc;
  final ReviewTemplateStepModel step;
  final List<ReviewStepFile> files;
  final String cacheStorageDir;

  const ContentPreviewWidget({
    Key? key,
    required this.makeReportBloc,
    required this.step,
    required this.files,
    required this.cacheStorageDir,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stepFiles = files.reversed.toList();
    final size = stepFiles.isNotEmpty || step.contentImage != null
        ? MediaQuery.of(context).size.width / 2.2
        : 0.0;
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 15),
      child: SizedBox(
        height: size,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            cacheExtent: MediaQuery.of(context).size.width * 10,
            itemCount:
                step.contentImage != null ? files.length + 1 : files.length,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 16),
            itemBuilder: (context, index) {
              final stepFile = index == 0 && step.contentImage != null
                  ? null
                  : stepFiles[step.contentImage != null ? index - 1 : index];
              return index == 0 && step.contentImage != null
                  ? _buildExamplePhoto(context)
                  : ContentItemWidget(
                      stepFile: stepFile!,
                      step: step,
                      stepFilesList: files,
                      stepContentType: StepContentTypeExt.parse(stepFile.type),
                      index: files.length -
                          (step.contentImage != null ? index - 1 : index),
                    );
            }),
      ),
    );
  }

  Widget _buildExamplePhoto(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(0xFF89B5FC))),
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: AspectRatio(
            aspectRatio: 1,
            child: step.contentImage?.startsWith('http://') == true ||
                    step.contentImage?.startsWith('https://') == true
                ? Image.network(
                    step.contentImage!,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                : Image.file(
                    File(join(cacheStorageDir, basename(step.contentImage!))),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                S.of(context).example,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
