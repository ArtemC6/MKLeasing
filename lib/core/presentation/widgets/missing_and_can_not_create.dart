import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/stub_widget.dart';
import 'package:leasing_company/features/home/presentation/bottom_nav_bar_items.dart';
import 'package:leasing_company/generated/l10n.dart';

@Deprecated(
    'Not enough flexible. Should be migrate to proxy widget with using StubWidget like MissingArticlesAndCanNotCreateWidget')
class MissingAndCanNotCreateWidget extends StubWidget {
  final String missingItemsName;

  const MissingAndCanNotCreateWidget({
    Key? key,
    required this.missingItemsName,
  }) : super(key: key);

  @override
  String getTitle(BuildContext context) => S.of(context).itemCreationNotAvailable(missingItemsName);

  @override
  String? getDescription(BuildContext context) =>
      S.of(context).creationOfItemsIsNotAvailableDescription(missingItemsName);

  @override
  Widget? buildHeaderWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF246BFD).withOpacity(0.3), Color(0xFF246BFD).withOpacity(0.7)],
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/lock.svg',
              height: 70,
              width: 70,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget? buildBottomWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: CustomOutlinedButton(
        text: S.of(context).toMain,
        backgroundColor: Color(0xFF246BFD),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => true,
            arguments: Modules.main.getIndex(),
          );
        },
      ),
    );
  }
}
