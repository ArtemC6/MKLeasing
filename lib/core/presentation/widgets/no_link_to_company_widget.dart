import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/stub_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

/*
 Используется на экранах
  - Создание проверки
  - Создание задачи
*/
class NoLinkToCompanyWidget extends StubWidget {
  @override
  String getTitle(BuildContext context) => 'Вы не привязаны к компании';

  @override
  Widget? buildHeaderWidget(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF246BFD).withOpacity(0.3),
                    Color(0xFF246BFD).withOpacity(0.7)
                  ],
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
        ),
      ],
    );
  }

  @override
  Widget? buildBottomWidget(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: CustomOutlinedButton(
          text: S().switchToSignIn,
          backgroundColor: Color(0xff246BFD),
          verticalPadding: 18,
          onPressed: (){ Navigator.pushReplacementNamed(context, '/login');}),
    );
  }
}
