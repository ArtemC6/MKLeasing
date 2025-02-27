import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? initialValue;
  final String hintText;
  final Function(String) onChanged;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isValueValid;
  final int? maxLength;
  final bool isCounterVisible;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    this.initialValue,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.inputFormatters,
    this.isValueValid = true,
    this.maxLength,
    this.isCounterVisible = false,
    this.onFieldSubmitted,
    this.controller,
    this.contentPadding,
    this.suffixIcon,
    this.textInputAction,
    this.textStyle,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final _controller = widget.controller ?? TextEditingController();
  final _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
    _focusNode.addListener(() {
      if (mounted) {
        if (_focusNode.hasFocus) {
          setState(() {
            _hasFocus = true;
          });
        } else {
          setState(() {
            _hasFocus = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.isValueValid
                ? Color(0xFFFDFDFD)
                : Colors.red.withOpacity(0.08),
            border: Border.all(
              color: widget.isValueValid
                  ? _hasFocus || _controller.text.isNotEmpty
                      ? Color(0xFF246BFD)
                      : Color(0xFFE1E0E0)
                  : Colors.red,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    maxLength: widget.maxLength ?? 255,
                    keyboardType: widget.keyboardType,
                    minLines: widget.minLines ?? 1,
                    maxLines: widget.maxLines ?? 3,
                    style: widget.textStyle ?? TextStyle(fontSize: 16),
                    onFieldSubmitted: widget.onFieldSubmitted,
                    textInputAction: widget.textInputAction,
                    onChanged: (value){
                      setState(() {});
                      widget.onChanged(value);
                    },
                    focusNode: _focusNode,
                    inputFormatters: widget.inputFormatters,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: widget.contentPadding ??
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(fontSize: 16, color: Color(0xFF9E9E9E)),
                    ),
                  ),
                ),
                if(widget.suffixIcon != null) widget.suffixIcon!,
              ],
            ),
          ),
        ),
        if (widget.isCounterVisible) SizedBox(height: 6),
        if (widget.isCounterVisible)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_controller.text.length}/${widget.maxLength ?? 255}',
              style: TextStyle(
                color: _hasFocus ? Color(0xFF246BFD) : Colors.black,
              ),
            ),
          ),
      ],
    );
  }
}
