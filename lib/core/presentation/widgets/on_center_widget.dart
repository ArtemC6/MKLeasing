import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';

class OnCenterWidget extends StatefulWidget {
  final String? message;
  final Widget? widget;

  OnCenterWidget({this.message, this.widget});

  @override
  State<StatefulWidget> createState() => OnCenterWidgetState();
}

class OnCenterWidgetState extends State<OnCenterWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: widget.widget != null
                    ? widget.widget
                    : Text(
                        widget.message ?? S.of(context).onCenterWidgetUndefined,
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
              )
            ],
          ),
        )
      ],
    );
  }
}
