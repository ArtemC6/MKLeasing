import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/core/presentation/widgets/custom_divider.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:path/path.dart';

class StepDetailsPage extends StatelessWidget {
  final ReviewTemplateStepModel step;
  final String cacheStorageDir;

  StepDetailsPage(this.step, this.cacheStorageDir);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(step.title),
      ),
      body: ListView(physics: BouncingScrollPhysics(), children: [
        SizedBox(height: 16),
        if (step.contentImage != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Container(
                    child: step.contentImage?.startsWith('http://') == true || step.contentImage?.startsWith('https://') == true
                        ? Image.network(
                            step.contentImage!,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          )
                        : Image.file(
                            File(
                              join(cacheStorageDir, basename(step.contentImage!)),
                            ),
                          ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          S.of(context).example,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (step.contentImage != null && step.contentText != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 6),
            child: CustomDivider(),
          ),
        ],
        if (step.contentText != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlackBoldText(
              S.of(context).taskExecutionStepDetailDescriptionTitle,
              withRedStar: false,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              step.contentText!,
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
        SizedBox(height: 36),
      ]),
    );
  }
}
