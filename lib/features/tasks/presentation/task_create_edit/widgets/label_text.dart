import 'package:flutter/material.dart';

class LabelTextWidget extends StatelessWidget {
  final String text;
  final bool isRequired;

  const LabelTextWidget({
    Key? key,
    required this.text,
    required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 6),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: text + ':',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
        isRequired
            ? TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              )
            : TextSpan(),
      ])),
    );
  }
}
