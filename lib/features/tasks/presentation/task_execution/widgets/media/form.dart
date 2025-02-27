import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/core/presentation/widgets/custom_checkbox_field.dart';
import 'package:leasing_company/core/presentation/widgets/custom_date_picker_widget.dart';
import 'package:leasing_company/core/presentation/widgets/custom_dropdown.dart';
import 'package:leasing_company/core/presentation/widgets/custom_radiobutton_group.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_field.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_form_field_type_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_hash_service.dart';

class FormWidget extends StatefulWidget {
  final ReviewTemplateStepFormModel form;
  final void Function(Map<String, dynamic> rawForm) onChange;
  final Map<String, dynamic>? initialRawForm;
  final bool isNeedToShowValidateResults;

  FormWidget({
    required this.form,
    required this.onChange,
    required this.initialRawForm,
    this.isNeedToShowValidateResults = false,
  });

  @override
  State<StatefulWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final FileHashService fileHashService = getIt();
  final ReviewStepFileRepository reviewStepFileRepository = getIt();
  bool init = false;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    widget.form.fields!
        .where(
            (field) => field.type!.keyword != ReviewTemplateFormFieldType.hint)
        .forEach((ReviewTemplateStepFormFieldEntity field) {
      if ([
        ReviewTemplateFormFieldType.text,
        ReviewTemplateFormFieldType.number,
        ReviewTemplateFormFieldType.date,
      ].contains(field.type!.keyword)) {
        data[field.slug] = widget.initialRawForm?[field.slug] ?? '';
      } else if ([
        ReviewTemplateFormFieldType.checkbox,
      ].contains(field.type!.keyword)) {
        data[field.slug] = widget.initialRawForm?[field.slug] ?? [];
      } else if ([
        ReviewTemplateFormFieldType.radiobutton,
      ].contains(field.type!.keyword)) {
        data[field.slug] = widget.initialRawForm?[field.slug];
      } else if ([
        ReviewTemplateFormFieldType.select,
      ].contains(field.type!.keyword)) {
        data[field.slug] = widget.initialRawForm?[field.slug];
      }
    });
    super.initState();
    setState(() => init = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!init) {
      return Text('Loading...');
    }
    return Column(
      children: [
        ...widget.form.fields!
            .map(
              (field) => Column(
                children: [
                  SizedBox(height: 8),
                  _formBuilder(context, field),
                  SizedBox(height: 16),
                ],
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _formBuilder(
      BuildContext context, ReviewTemplateStepFormFieldEntity field) {
    if (field.type!.keyword == ReviewTemplateFormFieldType.text) {
      return _buildTextField(context, field);
    } else if (field.type!.keyword == ReviewTemplateFormFieldType.number) {
      return _buildNumberField(context, field);
    } else if (field.type!.keyword == ReviewTemplateFormFieldType.date) {
      return _buildDateField(context, field);
    } else if (field.type!.keyword == ReviewTemplateFormFieldType.select) {
      return _buildSelectField(context, field);
    } else if (field.type!.keyword == ReviewTemplateFormFieldType.checkbox) {
      return _buildCheckboxField(context, field);
    } else if (field.type!.keyword == ReviewTemplateFormFieldType.radiobutton) {
      return _buildRadiobuttonField(context, field);
    } else if (field.type!.keyword == ReviewTemplateFormFieldType.hint) {
      return _buildHintField(context, field);
    }
    return Text(field.title);
  }

  Widget _buildTextField(
          BuildContext context, ReviewTemplateStepFormFieldEntity field) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlackBoldText(
            field.title,
            withRedStar: field.properties.required == true,
          ),
          SizedBox(height: 10),
          CustomTextField(
            hintText: S.of(context).myTextFieldDefaultTextHint,
            initialValue: data[field.slug],
            isValueValid: !(widget.isNeedToShowValidateResults &&
                field.properties.required == true &&
                (data[field.slug].toString() == '' ||
                    data[field.slug].toString() == 'null')),
            minLines: field.properties.bigText == true ? 3 : 1,
            maxLines: 5,
            onChanged: (value) {
              data[field.slug] = value;
              widget.onChange(data);
            },
          ),
        ],
      );

  Widget _buildNumberField(
          BuildContext context, ReviewTemplateStepFormFieldEntity field) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlackBoldText(
            field.title,
            withRedStar: field.properties.required == true,
          ),
          SizedBox(height: 10),
          CustomTextField(
            hintText: S.of(context).myTextFieldDefaultNumberHint,
            initialValue: data[field.slug],
            keyboardType: TextInputType.phone,
            isValueValid: !(widget.isNeedToShowValidateResults &&
                field.properties.required == true &&
                (data[field.slug].toString() == '' ||
                    data[field.slug].toString() == 'null')),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
            ],
            onChanged: (value) {
              data[field.slug] = value;
              widget.onChange(data);
            },
          ),
        ],
      );

  Widget _buildDateField(
          BuildContext context, ReviewTemplateStepFormFieldEntity field) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlackBoldText(
            field.title,
            withRedStar: field.properties.required == true,
          ),
          SizedBox(height: 10),
          CustomDatePickerWidget(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime(DateTime.now().year + 50),
            isValueValid: !(widget.isNeedToShowValidateResults &&
                field.properties.required == true &&
                (data[field.slug].toString() == '' ||
                    data[field.slug].toString() == 'null')),
            initialDate: data[field.slug] != null &&
                    data[field.slug].toString().isNotEmpty
                ? DateFormat(field.properties.plusTime == true
                        ? 'dd.MM.yyyy HH:mm'
                        : 'dd.MM.yyyy')
                    .parse(data[field.slug])
                : null,
            onDateChanged: (DateTime date) {
              final formattedDate = DateFormat(field.properties.plusTime == true
                      ? 'dd.MM.yyyy HH:mm'
                      : 'dd.MM.yyyy')
                  .format(date);
              data[field.slug] = formattedDate;
              widget.onChange(data);
            },
          ),
        ],
      );

  Widget _buildSelectField(
      BuildContext context, ReviewTemplateStepFormFieldEntity field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlackBoldText(
          field.title,
          withRedStar: field.properties.required == true,
        ),
        SizedBox(height: 10),
        CustomDropdownWidget<String>(
          items: field.properties.options!,
          initialValue: data[field.slug],
          isValid: !(widget.isNeedToShowValidateResults &&
              field.properties.required == true &&
              (data[field.slug].toString() == '' ||
                  data[field.slug].toString() == 'null')),
          onChanged: (value) {
            data[field.slug] = value;
            setState(() {});
            widget.onChange(data);
          },
          isRequiredField: false,
          toDropdownItemText: (item) => item,
          hintText: S.of(context).reviewTemplateFormStepScreenDropdownHintText,
        ),
      ],
    );
  }

  Widget _buildCheckboxField(
          BuildContext context, ReviewTemplateStepFormFieldEntity field) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: BlackBoldText(
              field.title,
              withRedStar: field.properties.required == true,
            ),
          ),
          SizedBox(height: 9),
          ...field.properties.options!
              .map(
                (option) => CustomCheckBoxField(
                  title: option,
                  value: data[field.slug].contains(option),
                  onChanged: (bool? value) {
                    if (value == true)
                      data[field.slug].add(option);
                    else
                      data[field.slug].remove(option);
                    setState(() {});
                    widget.onChange(data);
                  },
                ),
              )
              .toList(),
        ],
      );

  Widget _buildRadiobuttonField(
      BuildContext context, ReviewTemplateStepFormFieldEntity field) {
    final selectedItemIndex =
        (field.properties.options as List).indexOf(data[field.slug]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: BlackBoldText(
            field.title,
            withRedStar: field.properties.required == true,
          ),
        ),
        SizedBox(height: 7),
        CustomRadioButtonsGroup<String>(
          items: field.properties.options!,
          onSelected: (value, int index, bool isSelected) {
            setState(
              () => data[field.slug] = field.properties.options![index],
            );
            widget.onChange(data);
          },
          isNeedToShowValidation: widget.isNeedToShowValidateResults &&
              field.properties.required == true,
          selectedItemIndex: selectedItemIndex != -1 ? selectedItemIndex : null,
          getTitle: (value) => value,
        ),
      ],
    );
  }

  Widget _buildHintField(
          BuildContext context, ReviewTemplateStepFormFieldEntity field) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(field.properties.content!),
            ],
          ),
        ),
      );
}
