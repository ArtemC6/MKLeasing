import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  showSuccessToast(BuildContext context, String text,
      {ToastGravity toastGravity = ToastGravity.BOTTOM}) {
    _showToast(context, text, Colors.green, toastGravity);
  }

  showFailureToast(
    BuildContext context,
    String text, {
    ToastGravity toastGravity = ToastGravity.BOTTOM,
    Color color = Colors.red,
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    _showToast(context, text, color, toastGravity, toastLength: toastLength);
  }

  _showToast(
      context, String text, Color backgroundColor, ToastGravity toastGravity,
      {Toast toastLength = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: toastGravity,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
