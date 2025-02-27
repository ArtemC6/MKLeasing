import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_form_field.dart';
import 'package:leasing_company/features/registration/domain/repositories/sign_up_repository.dart';
import 'package:leasing_company/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:leasing_company/features/registration/presentation/page/registration_user_info_page.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistrationIdPage extends StatefulWidget {
  RegistrationIdPage({Key? key}) : super(key: key);

  @override
  State<RegistrationIdPage> createState() => _RegistrationIdPageState();
}

class _RegistrationIdPageState extends State<RegistrationIdPage> {
  TextEditingController registrationID = TextEditingController();
  final ToastService toastService = getIt();
  String enteredTenantId = '';
  var maskFormatter = MaskTextInputFormatter(
      mask: '####-####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegistrationBloc(signUpRepository: getIt<SignUpRepository>()),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (BuildContext context, state) {
          if (state is SignUpBeginSuccessState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RegistrationUserInfoPage(
                      tenantIdFromBegin:
                          int.parse(enteredTenantId.replaceAll('-', '')),
                    )));
          }
          if (state is SignUpErrorState) {
            toastService.showFailureToast(
                context, S.of(context).networkException);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                bottomOpacity: 0.0,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  S.of(context).registerFirstScreenTitle,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff212121),
                      fontWeight: FontWeight.w700),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 131.0, right: 24, left: 24),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: BlackBoldText(
                            'ID',
                            withRedStar: true,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        onChanged: (value) => setState(() {
                          enteredTenantId = value;
                          if (state is SignUpValidationFailureState) {
                            state.errors['tenant_id']?.clear();
                          }
                        }),
                        hintText: S().enterIdForRegistration,
                        controller: registrationID,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatter],
                        errorText: state is SignUpValidationFailureState
                            ? state.errors['tenant_id']?.join("\n")
                            : state is SignUpDisabledState
                                ? state.error
                                : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(color: Color(0xffE1E0E0), width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                BorderSide(color: Color(0xffE1E0E0), width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Color(0xff246BFD))),
                      ),
                      SizedBox(height: 24),
                      CustomOutlinedButton(
                        text: S.of(context).makeReportPageContinue,
                        backgroundColor: registrationID.text.isEmpty
                            ? Color(0xff476EBE)
                            : Color(0xff246BFD),
                        verticalPadding: 18,
                        onPressed: !(state is SignUpInProgressState)
                            ? () {
                                BlocProvider.of<RegistrationBloc>(context).add(
                                  SignUpBeginButtonPressedEvent(
                                      tenantId: enteredTenantId != ''
                                          ? int.parse(enteredTenantId
                                              .replaceAll('-', ''))
                                          : null),
                                );
                              }
                            : () {},
                      ),
                      SizedBox(height: 26),
                      SizedBox(
                        height: 76,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: S().enterIdForAccountIdentification,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff212121)),
                              children: <TextSpan>[
                                TextSpan(
                                  text: S().getIdFromManager,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xff9E9E9E)),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
