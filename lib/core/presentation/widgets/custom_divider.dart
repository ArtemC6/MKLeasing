import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Color(0xFF89B5FC).withOpacity(0.5),
      indent: 16,
      endIndent: 16,
      thickness: 1,
    );
  }
}
