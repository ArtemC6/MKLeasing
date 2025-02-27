import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_field.dart';
import 'package:leasing_company/generated/l10n.dart';

class StepEditableTitle extends StatefulWidget {
  final String title;
  final bool isTitleEditable;
  final Function(String) onChanged;

  const StepEditableTitle({
    Key? key,
    required this.title,
    required this.isTitleEditable,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StepEditableTitle();
}

class _StepEditableTitle extends State<StepEditableTitle> {
  late String title = widget.title;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return isEditMode
        ? CustomTextField(
            initialValue: widget.title,
            hintText: S.of(context).fillInTheField,
            textInputAction: TextInputAction.done,
            onChanged: (value) => title = value,
            maxLength: 150,
            textStyle: TextStyle(fontWeight: FontWeight.w600),
            onFieldSubmitted: (_) {
              setState(() {
                widget.onChanged(title);
                isEditMode = !isEditMode;
              });
            },
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onChanged(title);
                  isEditMode = !isEditMode;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: SvgPicture.asset(
                  'assets/icons/check_icon.svg',
                  color: Colors.green,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Flexible(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (widget.isTitleEditable) SizedBox(width: 12),
                if (widget.isTitleEditable)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditMode = !isEditMode;
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/icons/edit.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
              ]);
  }
}
