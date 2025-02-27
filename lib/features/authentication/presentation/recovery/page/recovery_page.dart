import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/core/presentation/icons/my_flutter_app_icons.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_form_field.dart';
import 'package:leasing_company/features/authentication/presentation/recovery/bloc/recovery_bloc.dart';
import 'package:leasing_company/features/authentication/presentation/recovery/bloc/recovery_event.dart';
import 'package:leasing_company/features/authentication/presentation/recovery/bloc/recovery_state.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';

class RecoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  String _phone = "";
  final _toastService = getIt<ToastService>();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecoveryBloc, RecoveryState>(
      listener: (context, state) {
        if (state is RecoverySuccessState) {
          _toastService.showSuccessToast(context,
              S.of(context).recoveryScreenPasswordHasBeenSentOnSpecifiedPhone);
          Navigator.pop(context);
        }
        if (state is RecoveryFailureState) {
          _toastService.showFailureToast(
              context, S.of(context).networkException);
        }
      },
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 17.5),
                  child: Text(
                    Api.appName,
                    style: TextStyle(color: Color(0xff9E9E9E), fontSize: 15),
                  ),
                ),
              ],
            ),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                S.of(context).recoveryScreenTitle,
                //change to recoveryScreenTitleAppBar
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(35.0),
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 50, top: 120),
                      child: Text(
                        S.of(context).recoveryScreenHintTitle,
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomTextFormField(
                      prefixIcon: Icon(
                        MyFlutterApp.stroke_1,
                        color: _phoneController.text.isEmpty
                            ? Color(0xff9E9E9E)
                            : Color(0xff130F26),
                      ),
                      //
                      fillColor: _phoneController.text.isEmpty
                          ? Colors.white
                          : Color.fromRGBO(36, 107, 253, 0.08),
                      hintText: S.of(context).recoveryScreenPhoneHint,
                      onChanged: (value) => setState(() {
                        _phone = value;
                        if (state is RecoveryValidationFailureState) {
                          state.errors['phone']?.clear();
                        }
                      }),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: _phoneController.text.isEmpty
                              ? Color(0xffDCDCDC)
                              : Color(0xff246BFD),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: _phoneController.text.isEmpty
                              ? Color(0xffDCDCDC)
                              : Color(0xff246BFD),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText: state is RecoveryValidationFailureState
                          ? state.errors['phone']?.join("\n")
                          : null,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9+]"))
                      ],
                      controller: _phoneController,
                      onFocusChange: (hasFocus) {
                        if (hasFocus && _phoneController.text.length == 0) {
                          _phoneController.text = '+7';
                        } else if (!hasFocus && _phoneController.text == '+7') {
                          _phoneController.text = '';
                        }
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              OutlinedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(16)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          _phoneController.text.isEmpty
                                              ? Color(0xff476EBE)
                                              : Color(0xff246BFD)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  )),
                                  //
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 104,
                                  child: Text(
                                    S
                                        .of(context)
                                        .recoveryScreenSendPasswordButtonTitle,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                onPressed: !(state is RecoverySendSmsState)
                                    ? () {
                                        BlocProvider.of<RecoveryBloc>(context)
                                            .add(RecoveryButtonPressedEvent(
                                                _phone));
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    state is RecoverySendSmsState
                        ? Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: CircularProgressIndicator(),
                          )
                        : Text(""),
                  ])),
            ));
      },
    );
  }
}
