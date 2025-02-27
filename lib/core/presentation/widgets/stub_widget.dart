import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';

abstract class StubWidget extends StatelessWidget {
  const StubWidget({Key? key}) : super(key: key);

  String getTitle(BuildContext context);

  String? getSubtitle(BuildContext context) => null;

  String? getDescription(BuildContext context) => null;

  Widget? buildDescriptionWidget(BuildContext context) => null;

  Widget? buildHeaderWidget(BuildContext context) => null;

  Widget? buildBottomWidget(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    String title = getTitle(context);
    String? subtitle = getSubtitle(context);
    String? description = getDescription(context);
    Widget? descriptionWidget = buildDescriptionWidget(context);
    Widget? headerWidget = buildHeaderWidget(context);
    Widget? bottomWidget = buildBottomWidget(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // HeaderWidget optional section
          if (headerWidget != null) ...[
            headerWidget,
            SizedBox(height: 20),
          ],

          // Title section
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xFF246BFD),
            ),
          ),

          // Subtitle optional section
          if (subtitle != null) ...[
            SizedBox(height: 16),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF246BFD),
              ),
            )
            // SizedBox(height: 16),
          ],

          // Description optional section
          if (descriptionWidget == null && description != null) ...[
            SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 17.0),
            ),
          ],

          // DescriptionWidget optional section
          if (descriptionWidget != null) ...[
            SizedBox(height: 16),
            descriptionWidget,
          ],

          // BottomWidget optional section
          if (bottomWidget != null) ...[
            SizedBox(height: 30),
            bottomWidget
          ],
        ],
      ),
    );
  }
}
