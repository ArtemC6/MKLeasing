import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:leasing_company/core/presentation/widgets/stub_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

/*
 Используется на экранах
  - Создание проверки
  - Создание задачи
*/
class MissingArticlesAndCanCreateWidget extends StubWidget {
  @override
  String getTitle(BuildContext context) => S.of(context).itemsMissing(S.of(context).objects);

  @override
  String? getSubtitle(BuildContext context) => S.of(context).reviewOrTaskCanNotBeCreatedWithoutAvailableArticles;

  @override
  Widget? buildDescriptionWidget(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: S.of(context).waitCreationArticlesOr,
          style: TextStyle(color: Colors.black87, fontSize: 17.0),
        ),
        TextSpan(
          text: S.of(context).articlesScreenAvailabledArticleNotFoundCanRegister2,
          style: TextStyle(color: Colors.blue, fontSize: 17.0),
          recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, '/articleTypes/choose'),
        ),
      ]),
    );
  }

  @override
  Widget? buildBottomWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/articleTypes/choose'),
      child: Stack(
        children: [
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.withOpacity(0.17), Colors.blue.withOpacity(0.27)],
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                CupertinoIcons.add,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
