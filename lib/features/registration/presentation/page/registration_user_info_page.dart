import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_form_field.dart';
import 'package:leasing_company/features/registration/domain/repositories/sign_up_repository.dart';
import 'package:leasing_company/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:leasing_company/features/registration/presentation/page/registration_success.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistrationUserInfoPage extends StatefulWidget {
  RegistrationUserInfoPage({Key? key, this.tenantIdFromBegin = 0})
      : super(key: key);
  final int tenantIdFromBegin;

  @override
  State<RegistrationUserInfoPage> createState() =>
      _RegistrationUserInfoPageState(tenantIdFromBegin);
}

class _RegistrationUserInfoPageState extends State<RegistrationUserInfoPage> {
  _RegistrationUserInfoPageState(this.tenantIdFromBegin);

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  final int tenantIdFromBegin;
  final ToastService toastService = getIt();

  MaskTextInputFormatter phoneMaskFormatter = MaskTextInputFormatter(
      mask: '+##################',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    phoneController.text = '+';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegistrationBloc(signUpRepository: getIt<SignUpRepository>()),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is SignUpFinishSuccessState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RegistrationSuccessPage(
                      awaitingValidation: state.awaitingValidation,
                    )));
          }

          if (state is SignUpDisabledState) {
            toastService.showFailureToast(
                context, state.error);
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
              resizeToAvoidBottomInset: true,
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
                padding: const EdgeInsets.only(left: 24.0, right: 24),
                child: Center(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              infoNumberRequiredField(
                                formatter: phoneMaskFormatter,
                                aboveText: S().loginScreenPhoneLabel,
                                hintText: S().recoveryScreenHintTitle,
                                controller: phoneController,
                                state: state,
                                errorKey: 'phone',
                              ),
                              infoTextField(
                                  aboveText: S().profileScreenEmail,
                                  hintText: S().enterEmail,
                                  controller: emailController,
                                  state: state,
                                  errorKey: 'email',
                                  isRequired: false),
                              infoTextField(
                                  aboveText: S().profileScreenSurname,
                                  hintText: S().enterLastName,
                                  controller: lastNameController,
                                  state: state,
                                  errorKey: 'lastname',
                                  isRequired: true),
                              infoTextField(
                                  aboveText: S().profileScreenName,
                                  hintText: S().enterName,
                                  controller: nameController,
                                  state: state,
                                  errorKey: 'firstname',
                                  isRequired: true),
                              infoTextField(
                                  aboveText:
                                      S().registerFirstScreenCompanyLabel,
                                  hintText: S().enterCompany,
                                  controller: companyController,
                                  state: state,
                                  errorKey: 'company',
                                  isRequired: false),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 38.0),
                            child: CustomOutlinedButton(
                              text: S.of(context).loginScreenSignupButtonTitle,
                              backgroundColor: phoneController.text.isEmpty ||
                                      nameController.text.isEmpty ||
                                      lastNameController.text.isEmpty
                                  ? Color(0xff476EBE)
                                  : Color(0xff246BFD),
                              verticalPadding: 18,
                              onPressed: !(state is SignUpInProgressState)
                                  ? () {
                                      BlocProvider.of<RegistrationBloc>(context)
                                          .add(
                                        SignUpFinishButtonPressedEvent(
                                            tenantId: tenantIdFromBegin,
                                            firstname: nameController.text,
                                            lastname: lastNameController.text,
                                            company: companyController.text,
                                            phone: phoneController.text,
                                            email: emailController.text),
                                      );
                                    }
                                  : () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget infoTextField(
      {required String aboveText,
      required String hintText,
      required TextEditingController controller,
      required RegistrationState state,
      required String errorKey,
      required bool isRequired}) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlackBoldText(
                      aboveText,
                      withRedStar: isRequired,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            CustomTextFormField(
              onChanged: (value) => setState(() {
                if (state is SignUpValidationFailureState) {
                  state.errors[errorKey]?.clear();
                }
              }),
              hintText: hintText,
              controller: controller,
              errorText: state is SignUpValidationFailureState
                  ? state.errors[errorKey]?.join("\n")
                  : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xffE1E0E0), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xff246BFD))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xffE1E0E0), width: 1)),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget infoNumberRequiredField({
    required String aboveText,
    required String hintText,
    required MaskTextInputFormatter formatter,
    required TextEditingController controller,
    required RegistrationState state,
    required String errorKey,
  }) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlackBoldText(
                      aboveText,
                      withRedStar: true,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            CustomTextFormField(
              onChanged: (value) => setState(() {
                if (state is SignUpValidationFailureState) {
                  state.errors[errorKey]?.clear();
                }
              }),
              keyboardType: TextInputType.phone,
              inputFormatters: [formatter],
              hintText: hintText,
              controller: controller,
              errorText: state is SignUpValidationFailureState
                  ? state.errors[errorKey]?.join("\n")
                  : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xffE1E0E0), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xff246BFD))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xffE1E0E0), width: 1)),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
