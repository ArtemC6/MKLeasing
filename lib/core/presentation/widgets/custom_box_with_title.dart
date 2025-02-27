import 'package:flutter/material.dart';

class CheckBoxWithTitle extends StatefulWidget {
  final bool initialValue;
  final String title;
  final Function(bool) onValueChanged;

  const CheckBoxWithTitle({
    Key? key,
    this.initialValue = false,
    required this.title,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<CheckBoxWithTitle> createState() => _CheckBoxWithTitleState();
}

class _CheckBoxWithTitleState extends State<CheckBoxWithTitle> {
  bool isCheckboxOn = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        widget.onValueChanged(!isCheckboxOn);
        setState(() {
          isCheckboxOn = !isCheckboxOn;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            AnimatedContainer(
              height: 24,
              width: 24,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isCheckboxOn ? Color(0xFF246BFD) : Colors.transparent,
                border: Border.all(color: Color(0xFF246BFD), width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: isCheckboxOn ? Colors.white : Colors.transparent,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              widget.title,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
