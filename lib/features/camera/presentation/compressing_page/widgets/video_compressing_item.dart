import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class VideoCompressingItem extends StatelessWidget {
  final MediaFileModel mediaFile;
  final double percents;
  final bool isCompressed;

  VideoCompressingItem({
    Key? key,
    required this.mediaFile,
    required this.isCompressed,
    required this.percents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.file(
                  File(mediaFile.stepFile!.compressedPath!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(100),
              ),
              child: CircularPercentIndicator(
                percent: isCompressed ? 1 : percents / 100,
                progressColor: isCompressed ? Colors.green : Colors.blue,
                radius: 45,
                lineWidth: 9.0,
                animateFromLastPercent: true,
                center: Text(
                  ' ${isCompressed ? 100 : percents.toInt()}%',
                  style: TextStyle(
                    color: isCompressed ? Colors.green : Colors.blue,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
