import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_form_field.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/bloc/reject_delegate_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/page/rejection_success_page.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RejectReportIngoPage extends StatefulWidget {
  final int reviewTemplateId;
  final String companyUuid;
  final String reviewOrTaskTitle;
  final String objectTitle;

  RejectReportIngoPage(
      {required this.reviewTemplateId,
      required this.companyUuid,
      required this.reviewOrTaskTitle,
      required this.objectTitle});

  @override
  State<RejectReportIngoPage> createState() => _RegistrationUserInfoPageState();
}

class _RegistrationUserInfoPageState extends State<RejectReportIngoPage> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController positionController = TextEditingController();

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
          RejectDelegateReportBloc(),
      child: BlocConsumer<RejectDelegateReportBloc, RejectDelegateReportState>(
        listener: (context, state) {
          if (state is RejectSuccessState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RejectionSuccessPage()));
          }
          if (state is RejectDelegateErrorState) {
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
                  S.of(context).rejection,
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
                              infoTextField(
                                  aboveText: S().rejectionReason,
                                  hintText: S().myTextFieldDefaultTextHint,
                                  controller: reasonController,
                                  state: state,
                                  errorKey: 'reason',
                                  isRequired: true,
                                  maxLines: null),
                              infoNumberRequiredField(
                                formatter: phoneMaskFormatter,
                                aboveText: S().newContractorPhoneNumber,
                                hintText: S().recoveryScreenHintTitle,
                                controller: phoneController,
                                state: state,
                                errorKey: 'new_user_phone',
                              ),
                              infoTextField(
                                aboveText: S().profileScreenSurname,
                                hintText: S().enterLastName,
                                controller: lastNameController,
                                state: state,
                                errorKey: 'new_user_name',
                                isRequired: false,
                              ),
                              infoTextField(
                                  aboveText:
                                      S().registerFirstScreenCompanyLabel,
                                  hintText: S().enterCompany,
                                  controller: companyController,
                                  state: state,
                                  errorKey: 'new_user_company_name',
                                  isRequired: false),
                              infoTextField(
                                  aboveText:
                                      S().registerFirstScreenPositionLabel,
                                  hintText: S().enterPosition,
                                  controller: positionController,
                                  state: state,
                                  errorKey: 'new_user_position',
                                  isRequired: false),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 38.0),
                            child: CustomOutlinedButton(
                              text: S.of(context).taskInfoRefuseButtonTitle,
                              backgroundColor: reasonController.text.isEmpty
                                  ? Color(0xff476EBE)
                                  : Color(0xff246BFD),
                              verticalPadding: 18,
                              onPressed: !(state is RejectInProgressState)
                                  ? () {
                                      BlocProvider.of<RejectDelegateReportBloc>(
                                              context)
                                          .add(
                                        RejectPressedEvent(
                                            companyUuid: widget.companyUuid,
                                            reviewTemplateId:
                                                widget.reviewTemplateId,
                                            reason: reasonController.text,
                                            newUserPhone: phoneController.text,
                                            newUserName:
                                                lastNameController.text,
                                            newUserCompanyName:
                                                companyController.text,
                                            newUserPosition:
                                                positionController.text,
                                            reviewOrTaskTitle:
                                                widget.reviewOrTaskTitle,
                                            objectTitle: widget.objectTitle),
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
      required RejectDelegateReportState state,
      required String errorKey,
      required bool isRequired,
      int? maxLines = 1}) {
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
              maxLines: maxLines,
              onChanged: (value) => setState(() {
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
    required String hintText,
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
                      withRedStar: false,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            CustomTextFormField(
              onChanged: (value) => setState(() {
                if (state is RejectDelegateValidationFailureState) {
                  state.errors[errorKey]?.clear();
                }
              }),
              keyboardType: TextInputType.phone,
              inputFormatters: [formatter],
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
}
