import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';

class SuccessOperationWidget extends StatelessWidget {
  final bool automaticallyImplyLeading;
  final String headLineText;
  final String successText;
  final String infoText;
  final String buttonText;
  final VoidCallback onPressed;

  const SuccessOperationWidget(
      {Key? key,
      required this.automaticallyImplyLeading,
      required this.headLineText,
      required this.successText,
      required this.infoText,
      required this.buttonText,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          headLineText,
          style: TextStyle(
              fontSize: 20,
              color: Color(0xff212121),
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 182.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              colors: <Color>[
                                Color(0xff0DAD1D),
                                Color(0xff1DD30D)
                              ],
                              tileMode: TileMode.mirror,
                            )),
                          ),
                        )),
                    SvgPicture.asset('assets/icons/white_checkmark.svg'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                  child: Text(successText,
                      style: TextStyle(
                          color: Color(0xff212121),
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w700,
                          fontSize: 20)),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18, bottom: 36),
                    child: Text(
                      infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'SF Pro Display'),
                    )),
                CustomOutlinedButton(
                    text: buttonText,
                    backgroundColor: Color(0xff246BFD),
                    verticalPadding: 18,
                    onPressed: onPressed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
