import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final Color? borderColor;
  final Color overlayColor;

  final Icon? icon;
  final String text;
  final VoidCallback onPressed;
  final double? verticalPadding;
  final double? horizontalPadding;
  final TextStyle? textStyle;

  const CustomOutlinedButton({
    Key? key,
    this.foregroundColor = Colors.white,
    this.backgroundColor = const Color(0xff476EBE),
    this.icon,
    required this.text,
    required this.onPressed,
    this.borderColor,
    this.overlayColor = Colors.white24,
    this.verticalPadding,
    this.horizontalPadding,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(overlayColor),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 16,
            vertical: verticalPadding ?? 12,
          ),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(padding: EdgeInsets.only(right: 20), child: icon!),
            Padding(
              padding: EdgeInsets.symmetric(vertical: icon == null ? 2.0 : 0),
              child: Text(text, style: textStyle ?? TextStyle(fontSize: 16.0)),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
