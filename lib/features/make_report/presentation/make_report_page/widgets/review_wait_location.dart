import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/managers/location_service.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewWaitLocationWidget extends StatefulWidget {
  final Function(CustomLocationAccuracy) changeAccuracyMode;
  final Function() onLocationUndefined;

  ReviewWaitLocationWidget({
    Key? key,
    required this.changeAccuracyMode,
    required this.onLocationUndefined,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewWaitLocationWidgetState();
}

class _ReviewWaitLocationWidgetState extends State<ReviewWaitLocationWidget> {
  int timerTicksCount = 0;
  late Stream<int>? timer;

  CustomLocationAccuracy _locationAccuracy = CustomLocationAccuracy.high;

  @override
  void initState() {
    super.initState();

    /// Value 250 milliseconds is used for smoother progress display
    timer = Stream.periodic(Duration(milliseconds: 250), _onTickTimer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(shadowColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context, 'pop'),
        icon: Icon(Icons.arrow_back),
      ),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('assets/icons/locating.svg'),
            SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                S.of(context).locationDetermining,
                style: TextStyle(
                  color: Color(0xFF246BFD),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(S.of(context).pleaseWait, style: TextStyle(fontSize: 16)),
            SizedBox(height: 26),
            StreamBuilder(
              stream: timer,
              builder: (BuildContext context, _) {
                return Row(
                  children: [
                    SizedBox(width: 16),
                    ...CustomLocationAccuracy.values
                        .map((e) => Expanded(
                            child: Column(
                              children: [
                                LinearPercentIndicator(
                                  percent: e.getLocatingProgressPercent(
                                    _locationAccuracy,
                                    timerTicksCount,
                                  ),
                                  progressColor:
                                      e.getProgressColor(_locationAccuracy),
                                  backgroundColor:
                                      Color(0xFF3699FF).withOpacity(0.2),
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  barRadius: Radius.circular(6),
                                  lineHeight: 7,
                                  animationDuration: 100,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  e.getLocalizedAccuracyMode(context),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                    SizedBox(width: 16),
                  ],
                );
              },
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                S.of(context).locatingDescription,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF9E9E9E)),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                S.of(context).locatingRecommendation,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _onTickTimer(int value) {
    timerTicksCount++;
    if (timerTicksCount == 120) {
      /// 120 ticks = 30 seconds
      if (_locationAccuracy != CustomLocationAccuracy.low) {
        timerTicksCount = 0;
        _locationAccuracy = _locationAccuracy.getNextAccuracyMode();
        widget.changeAccuracyMode.call(_locationAccuracy);
      } else {
        timerTicksCount = 0;
        widget.onLocationUndefined();
      }
      return value;
    }
    return value++;
  }
}
