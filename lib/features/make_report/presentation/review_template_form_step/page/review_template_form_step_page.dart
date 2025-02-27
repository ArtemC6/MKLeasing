import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/review_template_form_step/bloc/review_template_form_step_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/review_template_form_step/bloc/review_template_form_step_event.dart';
import 'package:leasing_company/features/make_report/presentation/review_template_form_step/bloc/review_template_form_step_state.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_form_field_type_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/media/form.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_hash_service.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:path/path.dart';

class ReviewTemplateFormStepPage extends StatefulWidget {
  final CompanyEntity company;
  final Review review;
  final ReviewTemplateStepModel step;
  final ReviewTemplateStepFormModel form;
  final ReviewStepFileDTO? stepFileDTO;
  final String? titleCounter;

  ReviewTemplateFormStepPage({
    required this.company,
    required this.review,
    required this.step,
    required this.form,
    this.stepFileDTO,
    this.titleCounter,
  });

  @override
  State<StatefulWidget> createState() => _ReviewTemplateFormStepPageState();
}

class _ReviewTemplateFormStepPageState extends State<ReviewTemplateFormStepPage> {
  final FileHashService fileHashService = getIt();
  final ReviewStepFileRepository reviewStepFileRepository = getIt();
  final DialogManager _dialogManager = getIt();
  late final ReviewTemplateFormStepBloc _bloc;
  Map<String, dynamic>? loadedData;
  Map<String, dynamic> data = {};
  bool isNeedToShowValidateResults = false;

  Map getFieldProperties(ReviewTemplateFormField field) {
    return jsonDecode(field.properties);
  }

  @override
  void initState() {
    if (widget.stepFileDTO != null) {
      var file = File(widget.stepFileDTO!.path!);
      if (file.existsSync()) {
        String rawData = file.readAsStringSync();
        loadedData = jsonDecode(rawData);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewTemplateFormStepBloc>(create: (ctx) {
      _bloc = ReviewTemplateFormStepBloc(
        company: widget.company,
        form: widget.form,
      );
      _bloc.add(ReviewTemplateFormStepLoadEvent());
      return _bloc;
    }, child: BlocBuilder<ReviewTemplateFormStepBloc, ReviewTemplateFormStepState>(builder: (context, state) {
      if (state is ReviewTemplateFormStepLoadInProgressState) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is ReviewTemplateFormStepReadyState) {
        if (data.isEmpty) _initFields(state);
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.titleCounter != null ? widget.form.title + ' ' + widget.titleCounter! : widget.form.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2.0,
                    left: 16,
                    right: 16,
                    top: 8,
                  ),
                  child: FormWidget(
                    form: widget.step.form!,
                    initialRawForm: data,
                    isNeedToShowValidateResults: isNeedToShowValidateResults,
                    onChange: (Map<String, dynamic> newData) {
                      data = newData;
                      _bloc.add(UpdatePageUiEvent());
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: CustomOutlinedButton(
                    backgroundColor: Color(0xFF246BFD),
                    text: S.of(context).taskExecutionFinishButtonTitle,
                    onPressed: () {
                      _onSaveButtonPressed(context);
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      }
      return Center(
        child: Text('Undefined error'),
      );
    }));
  }

  bool _validate() {
    bool isValidResult = true;
    widget.form.fields?.forEach((field) {
      if (field.properties.required == true && (data[field.slug].toString() == '' || data[field.slug].toString() == 'null')) {
        isValidResult = false;
      }
    });
    return isValidResult;
  }

  Future<void> _onSaveButtonPressed(BuildContext context) async {
    if (_validate()) {
      DateTime onDeviceCreatedAt = DateTime.now();
      final path =
          widget.stepFileDTO != null ? widget.stepFileDTO!.path : join(await getStorageDir(), "${onDeviceCreatedAt.millisecondsSinceEpoch / 1000}.json");

      File file = File(path!);
      await file.writeAsString(jsonEncode(data), flush: true);
      if (widget.stepFileDTO == null) {
        final stepFileDTO = ReviewStepFileDTO(
          type: widget.step.type.name,
          stepId: widget.step.localId,
          createdAt: onDeviceCreatedAt.toUtc(),
          onDeviceCreatedAt: onDeviceCreatedAt,
          path: path,
          hash: await fileHashService.md5Hash(path),
        );
        Navigator.pop(context, stepFileDTO);
      } else {
        Navigator.pop(context, null);
      }
    } else {
      isNeedToShowValidateResults = true;
      _dialogManager.showAlertDialog(
        context,
        S.of(context).taskExecutionNotAllConditionsCompleted,
      );
      _bloc.add(UpdatePageUiEvent());
    }
  }

  void _initFields(ReviewTemplateFormStepReadyState state) {
    state.fields.forEach((ReviewTemplateFormField field) {
      if ([
        ReviewTemplateFormFieldType.text,
        ReviewTemplateFormFieldType.number,
        ReviewTemplateFormFieldType.date,
      ].contains(field.type)) {
        data[field.slug] = loadedData?[field.slug] ?? '';
      } else if ([
        ReviewTemplateFormFieldType.checkbox,
      ].contains(field.type)) {
        data[field.slug] = loadedData?[field.slug] ?? [];
      } else if ([
        ReviewTemplateFormFieldType.radiobutton,
      ].contains(field.type)) {
        data[field.slug] = loadedData?[field.slug];
      } else if ([
        ReviewTemplateFormFieldType.select,
      ].contains(field.type)) {
        data[field.slug] = loadedData?[field.slug];
      }
    });
    _bloc.add(UpdatePageUiEvent());
  }
}
