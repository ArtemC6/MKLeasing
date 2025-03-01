import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/generated/l10n.dart';

class DelegationImpossiblePage extends StatefulWidget {
  @override
  State<DelegationImpossiblePage> createState() =>
      _DelegationImpossiblePageState();
}

class _DelegationImpossiblePageState extends State<DelegationImpossiblePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            S.of(context).delegation,
            style: TextStyle(
                fontSize: 20,
                color: Color(0xff212121),
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 162.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          width: 141,
                          height: 141,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                colors: <Color>[
                                  Color(0xff6F9EFF),
                                  Color(0xff246BFD),
                                ],
                                tileMode: TileMode.mirror,
                              )),
                            ),
                          )),
                      SvgPicture.asset('assets/icons/lock.svg'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0, bottom: 16),
                    child: Text(S().delegationImpossible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff246BFD),
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w700,
                            fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(S().contractorDelegateToIsUnregistered,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff246BFD),
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w700,
                            fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(S().contractorDelegateToIsUnregistered,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w400,
                            fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
