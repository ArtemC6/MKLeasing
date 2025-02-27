import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/success_operation_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

class RegistrationSuccessPage extends StatelessWidget {
  RegistrationSuccessPage({Key? key, required this.awaitingValidation}) : super(key: key);
  final bool awaitingValidation;

  @override
  Widget build(BuildContext context) {
    return awaitingValidation
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                S.of(context).registerFirstScreenTitle,
                style: TextStyle(fontSize: 20, color: Color(0xff212121), fontWeight: FontWeight.w700),
              ),
            ),
            body: tenantRegistrationSuccess(context))
        : SuccessOperationWidget(
            automaticallyImplyLeading: true,
            headLineText: S.of(context).registerFirstScreenTitle,
            successText: S().registrationSuccess,
            infoText: S.of(context).youWillGetMessageWithPassword,
            buttonText: S.of(context).switchToSignIn,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          );
  }
}

Widget tenantRegistrationSuccess(BuildContext context) {
  return Padding(
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
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
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
                SvgPicture.asset('assets/icons/white_checkmark.svg'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(S().registrationSuccess,
                  style: TextStyle(color: Color(0xff246BFD), fontFamily: 'SF Pro Display', fontWeight: FontWeight.w700, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 16, bottom: 36),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(12),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(12),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Container(
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                width: 12,
                                height: 12,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    color: Color(0xff246BFD),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0.5, top: 5),
                            child: DottedLine(
                              dashLength: 2,
                              dashGapLength: 2,
                              lineThickness: 1,
                              dashColor: Color(0xff246BFD),
                              direction: Axis.vertical,
                              lineLength: 33,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          S.of(context).youWillGetPasswordAfterVerification,
                          style: TextStyle(color: Color(0xff212121), fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'SF Pro Display'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      SizedBox(),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            width: 12,
                            height: 12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                color: Color(0xff246BFD),
                              ),
                            )),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(S.of(context).waitForVerification,
                              style: TextStyle(color: Color(0xff212121), fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'SF Pro Display')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomOutlinedButton(
                text: S.of(context).switchToSignIn,
                backgroundColor: Color(0xff246BFD),
                verticalPadding: 18,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                }),
          ],
        ),
      ),
    ),
  );
}
