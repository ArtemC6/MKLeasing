import 'package:flutter/material.dart';

class BuildFilterItem extends StatelessWidget {
  final String text;
  final bool isEnable;
  final Color color;
  final Function(bool) onTap;
  final double? width;
  final double? height;
  final double? fontSize;

  BuildFilterItem({
    Key? key,
    required this.text,
    required this.isEnable,
    required this.color,
    required this.onTap,
    this.width,
    this.height,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        onTap(!isEnable);
      },
      child: Ink(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: isEnable ? color : Colors.transparent,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isEnable ? Colors.white : color,
              fontSize: fontSize ?? 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ));
  }
}
