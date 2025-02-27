import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leasing_company/generated/l10n.dart';


enum TextFieldType {
  text,
  number,
  date,
}

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final TextFieldType textFieldType;
  final String? label;
  final String? helperText;
  final String? hintText;
  final String? errorText;
  String? value;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  bool? obscureText;
  final int? maxLength;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final bool? readOnly;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;
  final ValueChanged<bool>? onFocusChange;

  Widget? suffixIcon;
  Widget? prefixIcon;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;
  final Color? labelStyleColor;
  final FontWeight? edditableFontWeight;
  final EdgeInsetsGeometry? contentVerticalPadding;
  final String? labelText;
  InputBorder? border;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  double? labelFontSize;

  CustomTextFormField({
    this.textFieldType = TextFieldType.text,
    this.label,
    this.value,
    this.initialValue,
    this.errorText,
    this.helperText,
    this.hintText,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.validator,
    this.minLines,
    this.maxLines = 1,
    this.suffixIcon,
    this.prefixIcon,
    this.onFocusChange,
    this.padding,
    this.fillColor,
    this.labelText,
    this.labelStyleColor,
    this.edditableFontWeight,
    this.contentVerticalPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.labelFontSize,
  });

  @override
  State<StatefulWidget> createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  String get defaultHintText => {
        TextFieldType.text: S.of(context).myTextFieldDefaultTextHint,
        TextFieldType.number: S.of(context).myTextFieldDefaultNumberHint,
        TextFieldType.date: S.of(context).myTextFieldDefaultDateHint,
      }[widget.textFieldType]!;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.controller?.text = widget.value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: widget.labelFontSize ?? 14,
            ),
          ),
          SizedBox(height: 13),
        ],
        Container(
          padding: widget.padding ?? null,
          constraints: BoxConstraints(minHeight: 33),
          child: Focus(
              onFocusChange: widget.onFocusChange,
              child: TextFormField(
                validator: widget.validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: widget.controller,
                initialValue: widget.initialValue,
                cursorHeight: 17,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: widget.edditableFontWeight ?? null),
                decoration: InputDecoration(
                  fillColor:
                      widget.fillColor ?? Color.fromRGBO(250, 250, 250, 1),
                  labelText: widget.labelText ?? null,
                  labelStyle: TextStyle(
                      color: widget.labelStyleColor,
                      fontWeight: FontWeight.normal),
                  border: widget.border ??
                      OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                  enabledBorder: widget.enabledBorder ??
                      OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                  focusedBorder: widget.focusedBorder ??
                      OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffDCDADA), width: 1.0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                  prefixIcon: widget.prefixIcon ?? null,
                  suffixIcon: widget.suffixIcon ?? null,
                  filled: true,
                  hintText: widget.hintText ?? defaultHintText,
                  contentPadding: widget.contentVerticalPadding ??
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  isDense: true,
                  helperText: widget.helperText,
                  helperMaxLines: 3,
                  //widget.value != null && widget.value.length > 0 ? widget.label : null,
                  errorMaxLines: 3,
                  errorText:
                      widget.errorText != null && widget.errorText!.length > 0
                          ? widget.errorText
                          : null,
                ),
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                onChanged: (value) {
                  setState(() => widget.value = value);
                  widget.onChanged!(value);
                },
                onTap: widget.onTap,
                maxLength: widget.maxLength,
                obscureText: widget.obscureText!,
                readOnly: widget.readOnly!,
              )),
        ),
        if (widget.label != null) SizedBox(height: 16),
      ],
    );
  }
}
