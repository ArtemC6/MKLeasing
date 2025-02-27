import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class ReviewErrorWidget extends StatelessWidget {
  final String description;
  final bool showSettingButton;

  const ReviewErrorWidget(
    this.description, {
    this.showSettingButton = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 27),
              child: Text(
                description,
                //S.of(context).makeReportPageHaveNotLocationPermission,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            if (showSettingButton)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.transparent, width: 0),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xffE9F0FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                child: Text(
                  S.of(context).makeMediaPageOpenAppSettings,
                  style: TextStyle(
                      color: Color(0xff246BFD),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () => openAppSettings(),
              )
          ],
        ),
      ),
    );
  }
}
