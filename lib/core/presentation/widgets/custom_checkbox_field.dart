import 'package:flutter/material.dart';

class CustomCheckBoxField extends StatefulWidget {
  const CustomCheckBoxField({
    required this.title,
    required this.value,
    required this.onChanged,
    this.isValid = true,
  });

  final String title;
  final bool value;
  final void Function(bool?) onChanged;
  final bool isValid;

  @override
  _CustomCheckBoxFieldState createState() => _CustomCheckBoxFieldState();
}

class _CustomCheckBoxFieldState extends State<CustomCheckBoxField> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChanged(_isSelected);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              decoration: BoxDecoration(
                  color: _isSelected ? Color(0xff246BFD) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: widget.isValid ? Color(0xff246BFD) : Colors.red,
                    width: 2,
                  )),
              width: 24,
              height: 24,
              child: _isSelected
                  ? Icon(Icons.check_outlined, color: Colors.white, size: 16)
                  : null,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  widget.title,
                  maxLines: 50,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
