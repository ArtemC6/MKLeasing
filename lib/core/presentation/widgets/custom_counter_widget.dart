import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomCounterWidget extends StatefulWidget {
  final int? initialValue;
  final Function(int) onChanged;

  const CustomCounterWidget({
    Key? key,
    this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomCounterWidgetState();
}

class _CustomCounterWidgetState extends State<CustomCounterWidget> {
  late int counterValue = widget.initialValue ?? 1;
  late final controller = TextEditingController(text: counterValue.toString());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(Icons.remove, () {
          if (counterValue != 1) {
            FocusScope.of(context).unfocus();
            counterValue--;
            controller.text = counterValue.toString();
            widget.onChanged(counterValue);
          }
        }),
        SizedBox(
          width: 44,
          height: 50,
          child: TextField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                counterValue = int.tryParse(value) ?? counterValue;
                widget.onChanged(counterValue);
              }
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                counterText: ''),
            style: TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
            controller: controller,
            maxLength: 2,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
          ),
        ),
        _buildButton(
          Icons.add,
          () {
            FocusScope.of(context).unfocus();
            counterValue++;
            controller.text = counterValue.toString();
            widget.onChanged(counterValue);
          },
        ),
      ],
    );
  }

  Widget _buildButton(IconData icon, Function() onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Color(0xFF246BFD).withOpacity(0.1),
      highlightColor: Color(0xFF246BFD).withOpacity(0.1),
      onTap: onTap,
      child: Ink(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Color(0xFFECF8FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF246BFD), width: 1.5)),
        child: Center(
            child: Icon(
          icon,
          color: Color(0xFF246BFD),
          size: 22,
        )),
      ),
    );
  }
}
