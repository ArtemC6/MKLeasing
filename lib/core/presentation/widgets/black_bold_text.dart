import 'package:flutter/material.dart';

class BlackBoldText extends StatelessWidget {
  final String content;
  final bool withRedStar;
  final double? fontSize;

  BlackBoldText(this.content, {required this.withRedStar, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      if (withRedStar)
        TextSpan(
            text: '*',
            style: TextStyle(
              color: Color(0xffFF0F00),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      TextSpan(
          text: content,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.w600,
          ))
    ]));
  }
}
