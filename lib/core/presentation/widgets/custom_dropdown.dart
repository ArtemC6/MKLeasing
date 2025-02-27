import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdownWidget<T> extends StatefulWidget {
  final List<T>? items;
  final T? initialValue;
  final Function(dynamic) onChanged;
  final bool isRequiredField;
  final bool isEnable;
  final String Function(dynamic) toDropdownItemText;
  final String hintText;
  final String? emptyText;
  final bool isValid;
  final double? itemHeight;

  const CustomDropdownWidget({
    Key? key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
    required this.isRequiredField,
    this.isEnable = true,
    required this.toDropdownItemText,
    required this.hintText,
    this.emptyText,
    this.isValid = true,
    this.itemHeight = 60,
  }) : super(key: key);

  @override
  State<CustomDropdownWidget> createState() => CustomDropdownWidgetState<T>();
}

class CustomDropdownWidgetState<T> extends State<CustomDropdownWidget> {
  T? _value;

  @override
  Widget build(BuildContext context) {
    _value = widget.initialValue;
    return Opacity(
      opacity: widget.isEnable ? 1.0 : 0.5,
      child: AbsorbPointer(
        absorbing: !widget.isEnable,
        child: Container(
          height: widget.itemHeight,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: widget.isValid
                ? Color(0xFFFDFDFD)
                : Colors.red.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isValid
                  ? _value != null
                      ? Color(0xFF246BFD)
                      : Color(0xFFE1E0E0)
                  : Colors.red,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 2),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                isExpanded: true,
                itemHeight: null,
                borderRadius: BorderRadius.circular(12),
                hint: _buildHint(),
                menuMaxHeight: MediaQuery.sizeOf(context).height * 2 / 3,
                value: _value,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/dropdown_arrow.svg',
                  color: Color(0xFF9E9E9E),
                  width: 20,
                  height: 20,
                ),
                items: _buildItems(),
                onChanged: (value) {
                  if (value != null) {
                    widget.onChanged(value);
                    _value = value;
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildHint() {
    if ((widget.items != null && widget.items!.length == 0) && widget.emptyText != null) {
      return Text(widget.emptyText!);
    }

    return Text(
      widget.hintText,
      style: TextStyle(color: Color(0xFF9E9E9E)),
    );
  }

  List<DropdownMenuItem<T>> _buildItems() {
    if (widget.items == null) {
      return [
        DropdownMenuItem<T>(
            enabled: false,
            child: Center(
              child: CircularProgressIndicator(),
            )),
      ];
    }

    if (widget.items!.length == 0 && widget.emptyText != null) {
      return [
        DropdownMenuItem<T>(enabled: false, child: Text(widget.emptyText!)),
      ];
    }

    return widget.items!
        .map(
          (item) => DropdownMenuItem<T>(
            child: Text(
              widget.toDropdownItemText(item),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            value: item,
          ),
        )
        .toList();
  }
}
