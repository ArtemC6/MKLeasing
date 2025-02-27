import 'package:flutter/material.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/step_title.dart';

typedef FileableCallback = void Function(ReviewStepFile);

abstract class MediaWidget<Type> extends StatelessWidget {
  final ReviewTemplateStepModel step;
  final String actionTitle;
  final Icon actionIcon;
  final List<ReviewStepFile> files;
  final VoidCallback onPressAction;
  final FileableCallback onPressDelete;
  final FileableCallback onPressItem;

  MediaWidget({
    Key? key,
    required this.step,
    required this.actionTitle,
    required this.actionIcon,
    required this.onPressAction,
    required this.onPressDelete,
    required this.onPressItem,
    required this.files,
  }) : super(key: key);

  ImageProvider getPreviewWidget(ReviewStepFile file);

  Widget previewWidget(ReviewStepFile file, {double? width, double? height}) {
    return GestureDetector(
      onTap: () => onPressItem(file),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 7),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  spreadRadius: 0.7,
                  offset: Offset(0, 1),
                ),
              ],
              image: DecorationImage(
                image: getPreviewWidget(file),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0xffCDCDCD)),
          child: SizedBox(
              width: width ?? 115,
              height: height ?? 115,
              child: Stack(children: [
                Positioned(
                    top: -8,
                    right: -8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.all(0.0),
                        shape: CircleBorder(),
                        fixedSize: Size(20, 20),
                        minimumSize: Size(20, 20),
                        maximumSize: Size(20, 20),
                        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                        foregroundColor: Color(0xffC07777),
                      ),
                      onPressed: () => onPressDelete(file),
                      child: Icon(
                        Icons.close,
                        color: Color(0xffC07777),
                        size: 12,
                      ),
                    )),
              ]))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StepTitleWidget(step, files: files),

      if (step.subtitle != null)
        Padding(
            padding: EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
            ),
            child: Text(
              step.subtitle!,
              style: TextStyle(fontSize: 14),
            )),

      ContentTypeInfoWidget(
        multimedia: step.multimedia!,
        step: step,
        files: files,
      ),
      if (files.length > 0)
        Container(
          margin: EdgeInsets.only(top: 12),
          height: MediaQuery.of(context).size.width / 2.9,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 9),
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              return previewWidget(
                files[index],
                height: MediaQuery.of(context).size.width / 2.9,
                width: MediaQuery.of(context).size.width / 2.9,
              );
            },
          ),
        ),
    ]);
  }
}
