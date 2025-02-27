import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_field.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/make_report_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/report_preview_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/bloc/review_list_bloc.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_model.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_status.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/widgets/label_text.dart';
import 'package:leasing_company/generated/l10n.dart';

class DialogManager {
  Future<bool> showSaveMediaFilesDialog(BuildContext context) async {
    bool isNeedToSaveFiles = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          S.of(context).mediaFilesDoNotSaved,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 40,
                      decoration:
                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blueAccent, width: 2)),
                      child: Text(
                        S.of(context).makeReportPageNo,
                        style: TextStyle(fontSize: 16, color: Color(0xff246BFD), fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, left: 5, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      isNeedToSaveFiles = true;
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff246BFD),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        S.of(context).makeReportPageYes,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
    return isNeedToSaveFiles;
  }

  Future<bool?> showOnDeleteDialog(BuildContext context, String title) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(true),
                    child: Container(
                      height: 40,
                      decoration:
                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blueAccent, width: 3)),
                      child: Text(
                        S.of(context).makeReportPageYes,
                        style: TextStyle(fontSize: 16, color: Color(0xff246BFD), fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, left: 5, right: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(false),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff246BFD),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        S.of(context).makeReportPageNo,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> showApproveDialog(BuildContext context, String title) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(false),
                    child: Container(
                      height: 40,
                      decoration:
                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blueAccent, width: 3)),
                      child: Text(
                        S.of(context).makeReportPageNo,
                        style: TextStyle(fontSize: 16, color: Color(0xff246BFD), fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, left: 5, right: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(true),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff246BFD),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        S.of(context).makeReportPageYes,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> showInfoDialog(BuildContext context, String title) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) => Center(
        child: Container(
          margin: EdgeInsets.all(40),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.of(dialogContext).pop(true),
                child: Container(
                  height: 35,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color(0xff246BFD),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    S.of(context).ok,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showOnWillPopDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Text(
              S.of(context).makeReportPageAreYouSureForExit,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context, rootNavigator: true).pop(true),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blueAccent, width: 3)),
                          child: Text(
                            S.of(context).makeReportPageYes,
                            style: TextStyle(fontSize: 16, color: Color(0xff246BFD), fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 22.0, left: 5, right: 15),
                      child: GestureDetector(
                        onTap: () => Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pop(false),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xff246BFD),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            S.of(context).makeReportPageNo,
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<void> showAlertDialog(BuildContext context, String text, {String? okTitle}) async {
    if (okTitle == null) okTitle = S.of(context).alertDialogDefaultOkTitle;
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(true),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff246BFD),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        okTitle!,
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> showBoolDialog(BuildContext context, String text, {String? yesTitle, String? noTitle}) async {
    if (yesTitle == null) yesTitle = S.of(context).boolDialogDefaultApproveTitle;
    if (noTitle == null) noTitle = S.of(context).boolDialogDefaultDenyTitle;
    var result = await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(true),
                    child: Container(
                      height: 40,
                      decoration:
                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blueAccent, width: 3)),
                      child: Text(
                        yesTitle!,
                        style: TextStyle(fontSize: 16, color: Color(0xff246BFD), fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0, left: 5, right: 15),
                  child: GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(false),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff246BFD),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        noTitle!,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
    return result == true;
  }

  Future<void> showScheduledReviewInfoDialog(
    BuildContext context,
    InfoModal infoModal,
    ReviewModel model,
    CompanyEntity entity,
  ) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: BlocProvider.of<ReviewListBloc>(context),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(
            infoModal.titleTemplate.replaceAll('\${ReviewTemplateName}', model.name).replaceFirst('\${ArticleTitle}', model.article.title),
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          content: Text(
            infoModal.textTemplate.replaceAll('\${ReviewTemplateName}', model.name).replaceFirst('\${ArticleTitle}', model.article.title),
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 22.0, right: 10, left: 15),
                    child: GestureDetector(
                      onTap: () async {
                        await BlocProvider.of<ReviewListBloc>(context).notificationIsOpened(model.remoteId);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => model.status == ReviewStatus.scheduled
                                ? ReportPreviewPage(
                                    company: entity,
                                    article: model.article,
                                    template: ReviewTemplateModel.fromDBModel(model),
                                    review: model.review,
                                    isOpenedFromReviews: true,
                                  )
                                : MakeReportPage(
                                    company: entity,
                                    article: model.article,
                                    template: ReviewTemplateModel.fromDBModel(model),
                                    review: model.review,
                                    isOpenedFromReviews: false,
                                    index: 0,
                                  ),
                          ),
                        );
                        Navigator.of(context).pop();
                        context.read<ReviewListBloc>().add(InitialEvent());
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff246BFD),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          S.of(context).reviewsModalInfoRedirectButton,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 22.0, right: 15, left: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await BlocProvider.of<ReviewListBloc>(context).notificationIsOpened(model.remoteId);
                        Navigator.of(dialogContext).pop(true);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 3,
                          ),
                        ),
                        child: Text(
                          S.of(context).reviewsModalInfoLaterButton,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff246BFD),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String?> showStepSkipDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) => _StepSkipDialog(dialogContext: dialogContext),
    );
  }

  Future<String?> showAudioNameDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) => _AudioNameDialog(dialogContext: dialogContext),
    );
  }
}

class _AudioNameDialog extends StatefulWidget {
  final BuildContext dialogContext;

  const _AudioNameDialog({
    Key? key,
    required this.dialogContext,
  }) : super(key: key);

  @override
  State<_AudioNameDialog> createState() => _AudioNameDialogState();
}

class _AudioNameDialogState extends State<_AudioNameDialog> {
  bool isCommentValid = true;
  String comment = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(widget.dialogContext).viewInsets,
      child: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(widget.dialogContext).unfocus(),
          child: Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.fromLTRB(20, 6, 20, 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Material(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LabelTextWidget(text: S.of(context).audioFileName, isRequired: true),
                  SizedBox(height: 8),
                  CustomTextField(
                    hintText: S.of(context).fillInTheField,
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 50,
                    isValueValid: isCommentValid,
                    onChanged: (String newComment) {
                      comment = newComment;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => Navigator.of(widget.dialogContext).pop(),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F8FA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16,
                              ),
                              child: Text(
                                S.of(context).makeReportPageCancel,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Color(0xFF7E8299),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        highlightColor: Colors.white.withOpacity(0.2),
                        splashColor: Colors.white.withOpacity(0.2),
                        onTap: () {
                          if (comment.isEmpty) {
                            setState(() {
                              isCommentValid = false;
                            });
                          } else {
                            Navigator.of(widget.dialogContext).pop(comment);
                          }
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Color(0xFF00A3FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16,
                              ),
                              child: Text(
                                S.of(context).save,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepSkipDialog extends StatefulWidget {
  final BuildContext dialogContext;

  const _StepSkipDialog({
    Key? key,
    required this.dialogContext,
  }) : super(key: key);

  @override
  State<_StepSkipDialog> createState() => _StepSkipDialogState();
}

class _StepSkipDialogState extends State<_StepSkipDialog> {
  bool isCommentValid = true;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(widget.dialogContext).viewInsets,
      child: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(widget.dialogContext).unfocus(),
          child: Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Material(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8),
                  Text(
                    S.of(context).makeReportPageReasonForSkip,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: S.of(context).commentText,
                    minLines: 1,
                    maxLines: 3,
                    isValueValid: isCommentValid,
                    controller: commentController,
                    onChanged: (String newComment) {
                      setState(() {
                        isCommentValid = true;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.grey.withOpacity(0.1),
                          onTap: () => Navigator.of(widget.dialogContext).pop(),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xff246BFD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                S.of(context).makeReportPageCancel,
                                style: TextStyle(
                                  color: Color(0xff246BFD),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.white24,
                          onTap: () {
                            if (commentController.text.isEmpty) {
                              setState(() {
                                isCommentValid = false;
                              });
                            } else {
                              Navigator.of(widget.dialogContext).pop(commentController.text);
                            }
                          },
                          child: Ink(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              color: Color(0xff246BFD),
                              border: Border.all(color: Color(0xff246BFD)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                S.of(context).makeReportPageSend,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
