import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_form_field.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/bloc/reject_delegate_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/page/delegation_success_page.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DelegationUnregisteredUserInfoPage extends StatefulWidget {
  DelegationUnregisteredUserInfoPage({required this.companyUuid,
    required this.reviewTemplateId,
    required this.phone,
    this.reason = '', required this.reviewOrTaskTitle, required this.objectTitle});

  final String phone;
  final String companyUuid;
  final int reviewTemplateId;
  final String reason;
  final String reviewOrTaskTitle;
  final String objectTitle;
  final ToastService toastService = getIt();

  @override
  State<DelegationUnregisteredUserInfoPage> createState() =>
      _DelegationUnregisteredUserInfoPageState(
     );
}

class _DelegationUnregisteredUserInfoPageState
    extends State<DelegationUnregisteredUserInfoPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final ToastService toastService = getIt();

  MaskTextInputFormatter phoneMaskFormatter = MaskTextInputFormatter(
      mask: '+##################',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RejectDelegateReportBloc(),
      child: BlocConsumer<RejectDelegateReportBloc, RejectDelegateReportState>(
        listener: (context, state) {
          if (state is DelegateSuccessState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => DelegationSuccessPage()));
          }
          if (state is RejectDelegateErrorState) {
            toastService.showFailureToast(
                context, S
                .of(context)
                .networkException);
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
                  S
                      .of(context)
                      .delegation,
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
                                  isRequired: false),
                              infoTextField(
                                  aboveText: S().profileScreenName,
                                  hintText: S().enterName,
                                  controller: nameController,
                                  state: state,
                                  errorKey: 'firstname',
                                  isRequired: false),
                              infoTextField(
                                  aboveText:
                                  S().registerFirstScreenCompanyLabel,
                                  hintText: S().enterCompany,
                                  controller: companyController,
                                  state: state,
                                  errorKey: 'company',
                                  isRequired: false),
                              infoTextField(
                                  aboveText:
                                  S().registerFirstScreenPositionLabel,
                                  hintText: S().enterPosition,
                                  controller: positionController,
                                  state: state,
                                  errorKey: 'position',
                                  isRequired: false),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 38.0),
                            child: CustomOutlinedButton(
                              text: S
                                  .of(context)
                                  .toDelegate,
                              backgroundColor: Color(0xff246BFD),
                              verticalPadding: 18,
                              onPressed: !(state is DelegateInProgressState)
                                  ? () {
                                BlocProvider.of<RejectDelegateReportBloc>(
                                    context)
                                    .add(
                                  DelegatePressedEvent(
                                    companyUuid: widget.companyUuid,
                                    reviewTemplateId: widget.reviewTemplateId,
                                    phone: phoneController.text,
                                    reason: widget.reason,
                                    email: emailController.text,
                                    firstname: nameController.text,
                                    lastname: lastNameController.text,
                                    companyName: companyController.text,
                                    position: positionController.text,
                                    reviewOrTaskTitle: widget.reviewOrTaskTitle,
                                    objectTitle: widget.objectTitle,),
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

  Widget infoTextField({required String aboveText,
    required String hintText,
    required TextEditingController controller,
    required RejectDelegateReportState state,
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
              onChanged: (value) =>
                  setState(() {
                    if (state is RejectDelegateValidationFailureState) {
                      state.errors[errorKey]?.clear();
                    }
                  }),
              hintText: hintText,
              controller: controller,
              errorText: state is RejectDelegateValidationFailureState
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
    required MaskTextInputFormatter formatter,
    required TextEditingController controller,
    required RejectDelegateReportState state,
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
              readOnly: true,
              value: widget.phone,
              onChanged: (value) =>
                  setState(() {
                    if (state is RejectDelegateValidationFailureState) {
                      state.errors[errorKey]?.clear();
                    }
                  }),
              keyboardType: TextInputType.phone,
              inputFormatters: [formatter],
              controller: controller,
              errorText: state is RejectDelegateValidationFailureState
                  ? state.errors[errorKey]?.join("\n")
                  : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xff246BFD), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xff246BFD))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xff246BFD), width: 1)),
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
