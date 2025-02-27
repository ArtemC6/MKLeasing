import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';

class PickDateWidget extends StatelessWidget {
  final Function(DateTime) onDateChanged;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const PickDateWidget({
    Key? key,
    required this.onDateChanged,
    required this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Container(
            color: Color(0xFFE0E0E0),
            width: 40,
            height: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 10),
          child: Text(
            S.of(context).reviewTemplateFormStepScreenChooseData,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          indent: 16,
          endIndent: 16,
          height: 4,
          thickness: 1,
          color: Color(0xFFEEEEEE),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CalendarDatePicker(
            initialDate: initialDate ?? DateTime.now(),
            firstDate: firstDate ?? DateTime(DateTime.now().year - 1),
            lastDate: lastDate ?? DateTime(DateTime.now().year + 1),
            onDateChanged: (newDate) {
              onDateChanged(newDate);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
