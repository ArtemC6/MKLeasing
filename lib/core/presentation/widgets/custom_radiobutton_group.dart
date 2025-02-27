import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class CustomRadioButtonsGroup<T> extends StatefulWidget {
  const CustomRadioButtonsGroup({
    required this.items,
    required this.onSelected,
    this.selectedItemIndex,
    Key? key,
    this.itemStyle,
    required this.getTitle,
    this.isNeedToShowValidation = false,
  }) : super(key: key);

  final List<T> items;
  final String Function(T) getTitle;
  final Function(T value, int index, bool isSelected) onSelected;
  final int? selectedItemIndex;
  final TextStyle? itemStyle;
  final bool isNeedToShowValidation;

  @override
  State<CustomRadioButtonsGroup<T>> createState() =>
      _CustomRadioButtonsGroupState<T>();
}

class _CustomRadioButtonsGroupState<T>
    extends State<CustomRadioButtonsGroup<T>> {
  late final GroupButtonController _controller = GroupButtonController(
    selectedIndex: widget.selectedItemIndex,
  );

  @override
  Widget build(BuildContext context) {
    return GroupButton<T>(
      onSelected: (value, index, isSelected) =>
          widget.onSelected(value, index, isSelected),
      buttons: widget.items,
      controller: _controller,
      options: GroupButtonOptions(runSpacing: 0),
      buttonBuilder: (selected, T value, context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: _controller.selectedIndex != null
                  ? Color(0xff246BFD)
                  : widget.isNeedToShowValidation
                      ? Colors.red.withOpacity(0.9)
                      : Color(0xff246BFD),
              size: 26,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  widget.getTitle(value),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: widget.itemStyle ??
                      TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
