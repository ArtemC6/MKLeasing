import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/generated/l10n.dart';

class CustomSearchWidget extends StatefulWidget {
  final Function(String) onChanged;
  final String initialValue;

  const CustomSearchWidget({
    Key? key,
    required this.onChanged,
    this.initialValue = '',
  }) : super(key: key);

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  late final _controller = TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: (text) {
          widget.onChanged(text);
        },
        textInputAction: TextInputAction.search,
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 14),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              height: 20,
              width: 20,
              color: Color(0xFFBDBDBD),
            ),
          ),
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              // if (_controller.text.isEmpty) {
              //   //Todo add logic on pressed filter button
              // } else {
              _controller.text = '';
              widget.onChanged(_controller.text);
            },
            icon: _controller.text.isEmpty
                ? SizedBox.shrink()
                //SvgPicture.asset( todo filters button in search field
                //        'assets/icons/filter.svg',
                //        height: 24,
                //        width: 24,
                //        color: Color(0xFF246BFD),
                //      )
                : Icon(
                    Icons.clear,
                    size: 24,
                    color: Color(0xFFBDBDBD),
                  ),
          ),
          hintText: S.of(context).search,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Color(0xFFBDBDBD),
          ), //S.of(context).search,
        ),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
