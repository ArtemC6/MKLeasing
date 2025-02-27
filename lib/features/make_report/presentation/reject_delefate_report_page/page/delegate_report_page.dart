import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_form_field.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/bloc/reject_delegate_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/page/delegation_impossible_page.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/page/delegation_success_page.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/page/delegation_unregistered_user_info_page.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DelegateReportPage extends StatefulWidget {
  DelegateReportPage(
      {required this.companyUuid,
      required this.reviewTemplateId,
      required this.reviewOrTaskTitle,
      required this.objectTitle});

  final String companyUuid;
  final int reviewTemplateId;
  final String reviewOrTaskTitle;
  final String objectTitle;

  @override
  State<DelegateReportPage> createState() => _DelegateReportPageState();
}

class _DelegateReportPageState extends State<DelegateReportPage> {
  final ToastService toastService = getIt();
  TextEditingController reasonController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  MaskTextInputFormatter phoneMaskFormatter = MaskTextInputFormatter(
      mask: '+##################',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RejectDelegateReportBloc(),
      child: BlocConsumer<RejectDelegateReportBloc, RejectDelegateReportState>(
        listener: (context, state) {
          if (state is CheckPhoneForDelegationSuccessState) {
            if (state.exists) {
              BlocProvider.of<RejectDelegateReportBloc>(context).add(
                DelegatePressedEvent(
                    companyUuid: widget.companyUuid,
                    reviewTemplateId: widget.reviewTemplateId,
                    phone: phoneController.text,
                    reason: reasonController.text,
                    email: '',
                    firstname: '',
                    lastname: '',
                    companyName: '',
                    position: '',
                    reviewOrTaskTitle: widget.reviewOrTaskTitle,
                    objectTitle: widget.objectTitle),
              );
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DelegationSuccessPage()));
            } else {
              state.allowedCreate
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DelegationUnregisteredUserInfoPage(
                            companyUuid: widget.companyUuid,
                            reviewTemplateId: widget.reviewTemplateId,
                            reason: reasonController.text,
                            phone: phoneController.text,
                            reviewOrTaskTitle: widget.reviewOrTaskTitle,
                            objectTitle: widget.objectTitle,
                          )))
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DelegationImpossiblePage()));
            }
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
              resizeToAvoidBottomInset: false,
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
                padding: const EdgeInsets.only(top: 131.0, right: 24, left: 24),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: BlackBoldText(
                            S().contractorPhoneNumber,
                            withRedStar: true,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: CustomTextFormField(
                          onChanged: (value) => setState(() {
                            if (state is RejectDelegateValidationFailureState) {
                              state.errors['phone']?.clear();
                            }
                          }),
                          hintText: S().recoveryScreenHintTitle,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [phoneMaskFormatter],
                          errorText:
                              state is RejectDelegateValidationFailureState
                                  ? state.errors['phone']?.join("\n")
                                  : null,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: Color(0xffE1E0E0), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: Color(0xffE1E0E0), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff246BFD))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: BlackBoldText(
                            S().rejectionReason,
                            withRedStar: false,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: CustomTextFormField(
                          maxLines: null,
                          onChanged: (value) => setState(() {
                            if (state is RejectDelegateValidationFailureState) {
                              state.errors['tenant_id']?.clear();
                            }
                          }),
                          hintText: S().myTextFieldDefaultTextHint,
                          controller: reasonController,
                          keyboardType: TextInputType.text,
                          errorText:
                              state is RejectDelegateValidationFailureState
                                  ? state.errors['tenant_id']?.join("\n")
                                  : null,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: Color(0xffE1E0E0), width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: Color(0xffE1E0E0), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff246BFD))),
                        ),
                      ),
                      CustomOutlinedButton(
                        text: S.of(context).makeReportPageContinue,
                        backgroundColor: phoneController.text.isEmpty
                            ? Color(0xff476EBE)
                            : Color(0xff246BFD),
                        verticalPadding: 18,
                        onPressed: !(state
                                is CheckPhoneForDelegationProgressState)
                            ? () {
                                BlocProvider.of<RejectDelegateReportBloc>(
                                        context)
                                    .add(
                                  CheckPhoneForDelegatePressedEvent(
                                      companyUuid: widget.companyUuid,
                                      reviewTemplateId: widget.reviewTemplateId,
                                      phone: phoneController.text),
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
                              text: S().enterContractorPhoneNumberToDelegate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff212121)),
                              children: <TextSpan>[
                                TextSpan(
                                  text: S()
                                      .ifContractorUnregisteredEnterInfoAbout,
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
