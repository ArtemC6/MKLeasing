import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/core/managers/permission_manager.dart';
import 'package:leasing_company/core/presentation/icons/my_flutter_app_icons.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_form_field.dart';
import 'package:leasing_company/features/authentication/presentation/login/bloc/login_bloc.dart';
import 'package:leasing_company/features/authentication/presentation/login/bloc/login_event.dart';
import 'package:leasing_company/features/authentication/presentation/login/bloc/login_state.dart';
import 'package:leasing_company/features/registration/presentation/page/registration_id_page.dart';
import 'package:leasing_company/features/registration/presentation/page/registration_user_info_page.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String password = '';
  bool passwordInvisibility = true;
  TextEditingController phoneController = TextEditingController();
  final ToastService toastService = getIt();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      getIt<PermissionManager>()
          .checkPermissions(context, permissions: [Permission.notification]);
    } else {
      getIt<PermissionManager>().askPermissionOnce(Permission.notification);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, state) {
        return BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushReplacementNamed(context, '/home');
            }
            if (state is RegistrationSuccessState) {
              state.multiCompanyMode
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => RegistrationIdPage()))
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          RegistrationUserInfoPage()));
            }
            if (state is LoginErrorState) {
              toastService.showFailureToast(
                  context, S.of(context).networkException);
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 17.5),
                      child: Text(
                        Api.appName,
                        style:
                            TextStyle(color: Color(0xff9E9E9E), fontSize: 15),
                      ),
                    ),
                  ],
                ),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SizedBox()),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.only(bottom: 32),
                        child: Text(
                          S.of(context).loginScreenTitle,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        hintText: S.of(context).loginScreenPhoneHint,
                        fillColor: phoneController.text.isEmpty
                            ? Colors.white
                            : Color.fromRGBO(36, 107, 253, 0.08),
                        errorText: state is LoginValidationFailureState
                            ? state.errors['phone']?.join("\n")
                            : null,
                        onChanged: (value) => setState(() {
                          if (state is LoginValidationFailureState) {
                            state.errors['phone']?.clear();
                          }
                        }),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9+]")),
                        ],
                        prefixIcon: Icon(
                          MyFlutterApp.stroke_1,
                          color: phoneController.text.isEmpty
                              ? Color(0xff9E9E9E)
                              : Color(0xff130F26),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: phoneController.text.isEmpty
                                ? Color(0xffDCDCDC)
                                : Color(0xff246BFD),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: phoneController.text.isEmpty
                                ? Color(0xffDCDCDC)
                                : Color(0xff246BFD),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        controller: phoneController,
                        onFocusChange: (hasFocus) {
                          if (hasFocus && phoneController.text.length == 0) {
                            phoneController.text = '+7';
                          } else if (!hasFocus &&
                              phoneController.text == '+7') {
                            phoneController.text = '';
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      CustomTextFormField(
                        hintText: S.of(context).loginScreenPasswordHint,
                        fillColor: password.isEmpty
                            ? Colors.white
                            : Color.fromRGBO(36, 107, 253, 0.08),
                        errorText: state is LoginValidationFailureState
                            ? state.errors['password']?.join("\n")
                            : null,
                        onChanged: (value) => setState(() {
                          password = value;
                          if (state is LoginValidationFailureState) {
                            state.errors['password']?.clear();
                          }
                        }),
                        obscureText: passwordInvisibility,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordInvisibility
                                ? MyFlutterApp.union
                                : MyFlutterApp.show,
                            color: password.isEmpty
                                ? Color(0xff9E9E9E)
                                : Color(0xff130F26),
                          ),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              passwordInvisibility = !passwordInvisibility;
                            });
                          },
                        ),
                        prefixIcon: Icon(
                          MyFlutterApp.lock__2_,
                          color: password.isEmpty
                              ? Color(0xff9E9E9E)
                              : Color(0xff130F26),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: password.isEmpty
                                ? Color(0xffDCDCDC)
                                : Color(0xff246BFD),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: password.isEmpty
                                ? Color(0xffDCDCDC)
                                : Color(0xff246BFD),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                password.isEmpty || phoneController.text.isEmpty
                                    ? Color(0xff476EBE)
                                    : Color(0xff246BFD)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ))),
                        child: Row(children: [
                          Expanded(
                            child: !(state is LoginInProgressState)
                                ? Container(
                                    child: Text(
                                    S.of(context).loginScreenSignInButtonTitle,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                                : Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        ]),
                        onPressed: !(state is LoginInProgressState)
                            ? () {
                                BlocProvider.of<LoginBloc>(context).add(
                                  LoginButtonPressedEvent(
                                    phone: phoneController.text,
                                    password: password,
                                    context: context,
                                  ),
                                );
                              }
                            : null,
                      ),
                      SizedBox(height: 8),
                      CustomOutlinedButton(
                        text: S.of(context).loginScreenSignupButtonTitle,
                        backgroundColor: Color(0xff246BFD),
                        verticalPadding: 18,
                        onPressed: !(state is LoginInProgressState)
                            ? () {
                                BlocProvider.of<LoginBloc>(context).add(
                                  RegistrationButtonPressedEvent(),
                                );
                              }
                            : () {},
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text: S
                                    .of(context)
                                    .loginScreenRecoveryPasswordLink2,
                                style: TextStyle(
                                    color: Color(0xff246BFD), fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushNamed(
                                      context, '/sign/reset'),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 24.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: S.of(context).loginScreenUserAgreement1 +
                                    ' ',
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text:
                                    S.of(context).userAgreementAndPrivacyPolicy,
                                style: TextStyle(
                                  color: Color(0xff246BFD),
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async => await launchUrlString(
                                      Api.privacyUrl,
                                      mode: LaunchMode.externalApplication),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
