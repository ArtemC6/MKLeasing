import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:leasing_company/core/presentation/widgets/pick_date_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

class CustomDatePickerWidget extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isValueValid;

  const CustomDatePickerWidget({
    Key? key,
    this.initialDate,
    required this.onDateChanged,
    this.firstDate,
    this.lastDate,
    this.isValueValid = true,
  }) : super(key: key);

  @override
  State<CustomDatePickerWidget> createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _date = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(Duration(milliseconds: 50));
        showModalBottomSheet(
            context: context,
            isDismissible: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            builder: (context) {
              return PickDateWidget(
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
                onDateChanged: (date) {
                  if (mounted) {
                    setState(() {
                      widget.onDateChanged(date);
                      _date = date;
                    });
                  }
                },
                initialDate: _date,
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isValueValid
              ? Color(0xFFFDFDFD)
              : Colors.red.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isValueValid
                ? _date != null
                    ? Color(0xFF246BFD)
                    : Color(0xFFE1E0E0)
                : Colors.red,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              SizedBox(width: 18),
              Text(
                _date != null
                    ? DateFormat('dd.MM.yyyy').format(_date!)
                    : S.of(context).pickDate,
                style: TextStyle(
                    color: _date != null ? Colors.black : Color(0xFF9E9E9E),
                    fontSize: 16),
              ),
              Expanded(child: SizedBox.shrink()),
              SvgPicture.asset(
                'assets/icons/calendar.svg',
                color: Color(0xFF9E9E9E),
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 18),
            ],
          ),
        ),
      ),
    );
  }
}
