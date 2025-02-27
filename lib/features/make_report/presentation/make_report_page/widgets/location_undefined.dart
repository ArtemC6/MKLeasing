import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/generated/l10n.dart';

class LocationUndefinedWidget extends StatelessWidget {
  final Function() onRetry;
  final Function() onContinueWithoutGps;

  const LocationUndefinedWidget({
    Key? key,
    required this.onRetry,
    required this.onContinueWithoutGps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(shadowColor: Colors.transparent),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/location_undefined.svg'),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                S.of(context).failedToDetermineLocation,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF246BFD),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                S.of(context).startReviewWithoutInitialLocation, //replace on text
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 38),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              splashColor: Colors.white12,
              highlightColor: Colors.white12,
              onTap: onContinueWithoutGps,
              child: Ink(
                decoration: BoxDecoration(
                  color: Color(0xFFE9F0FF),
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 46),
                child: Text(
                  S.of(context).proceedToReview,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF246BFD),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              splashColor: Colors.white12,
              highlightColor: Colors.white12,
              onTap: onRetry,
              child: Ink(
                decoration: BoxDecoration(
                  color: Color(0xFF246BFD),
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 46),
                child: Text(
                  S.of(context).tryAgain,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
