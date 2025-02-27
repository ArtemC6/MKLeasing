import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/presentation/widgets/custom_checkbox_field.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_field.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/make_report/presentation/review_create_step/bloc/review_steps_create_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/review_create_step/bloc/review_steps_create_state.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_multimedia_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_type.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/widgets/label_text.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';

class ReviewStepsCreatePage extends StatefulWidget {
  final int? sectionId;
  final int? localSectionId;

  const ReviewStepsCreatePage({
    Key? key,
    required this.sectionId,
    required this.localSectionId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewStepsCreatePageState();
}

class _ReviewStepsCreatePageState extends State<ReviewStepsCreatePage> {
  final reviewTemplateStepRepository = getIt<ReviewTemplateStepRepository>();

  Company? company;
  ReviewTemplate? template;
  bool isNeedShowValidateResults = false;

  String title = "";
  String subtitle = "";
  List<StepContentType> newStepMultimediaTypes = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewStepsCreateBloc(),
      child: BlocBuilder<ReviewStepsCreateBloc, ReviewStepsCreateState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                title: Text(
                  S.of(context).reviewStepsCreateScreenNewStep,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(20, 4, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        LabelTextWidget(
                          text: S.of(context).reviewStepsCreateScreenName,
                          isRequired: true,
                        ),
                        CustomTextField(
                          hintText: S.of(context).fillInTheField,
                          maxLength: 150,
                          maxLines: 5,
                          isCounterVisible: true,
                          isValueValid: isNeedShowValidateResults ? title.isNotEmpty : true,
                          onChanged: (value) {
                            setState(() => title = value);
                          },
                        ),
                        LabelTextWidget(
                          text: S.of(context).reviewStepsCreateScreenDescription,
                          isRequired: false,
                        ),
                        CustomTextField(
                          hintText: S.of(context).fillInTheField,
                          maxLines: 10,
                          maxLength: 255,
                          isCounterVisible: true,
                          onChanged: (value) {
                            setState(() => subtitle = value);
                          },
                        ),
                        LabelTextWidget(
                          text: S.of(context).stepType,
                          isRequired: true,
                        ),
                        SizedBox(height: 10),
                        ...StepContentType.values.map((type) => CustomCheckBoxField(
                              title: getStepTypeWithLocalization(type.name, context),
                              value: newStepMultimediaTypes.contains(type),
                              isValid: isNeedShowValidateResults ? newStepMultimediaTypes.isNotEmpty : true,
                              onChanged: (value) {
                                if (value == true) {
                                  newStepMultimediaTypes.add(type);
                                }
                                if (value == false) {
                                  newStepMultimediaTypes.remove(type);
                                }
                                setState(() {});
                              },
                            )),
                        SizedBox(height: 24),
                      ],
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(title.isNotEmpty && newStepMultimediaTypes.isNotEmpty ? Color(0xff246BFD) : Color(0xff476EBE)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        )),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          S.of(context).reviewStepsCreateScreenCreate,
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        if (title.isNotEmpty && newStepMultimediaTypes.isNotEmpty) {
                          final newStepDTO = ReviewTemplateStepDTO(
                            title: title,
                            subtitle: subtitle,
                            type: ReviewTemplateStepType.multimedia.name,
                            required: false,
                            expandable: true,
                            repeatable: true,
                            canHaveViolation: true,
                            weight: 0,
                            requiredCommentWhenSkipping: false,
                            multimedia: newStepMultimediaTypes
                                .map((e) => ReviewTemplateStepMultimediaModel(
                                      stepContentType: e,
                                      multiple: true,
                                      minCount: 0,
                                      maxCount: 0,
                                    ))
                                .toList(),
                            comment: null,
                            form: null,
                            formId: null,
                            contentText: null,
                            contentImage: null,
                            contentMask: null,
                            sectionId: widget.sectionId,
                            isSelfCreated: true,
                            localSectionId: widget.localSectionId,
                          );
                          Navigator.pop(context, newStepDTO);
                        } else {
                          setState(() {
                            isNeedShowValidateResults = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String getStepTypeWithLocalization(String stepType, BuildContext context) {
    switch (stepType) {
      case 'photo':
        return S.of(context).reviewStepsCreateScreenPhoto;
      case 'video':
        return S.of(context).reviewStepsCreateScreenVideo;
      case 'document':
        return S.of(context).reviewStepsCreateScreenDocumentScan;
      case 'file':
        return S.of(context).reviewStepsCreateScreenFile;
      case 'audio':
        return S.of(context).audio;
      case 'picture':
        return S.of(context).picture;
      default:
        return 'Unexpected type';
    }
  }
}
