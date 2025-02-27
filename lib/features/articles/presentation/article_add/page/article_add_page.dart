import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/api/DadataService.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_field.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_form_field.dart';
import 'package:leasing_company/features/articles/presentation/article_add/bloc/article_add_bloc.dart';
import 'package:leasing_company/features/articles/presentation/article_add/bloc/article_add_event.dart';
import 'package:leasing_company/features/articles/presentation/article_add/bloc/article_add_state.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/widgets/label_text.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:leasing_company/features/articles/presentation/article_add/widgets/my_input_border.dart';

class ArticleAddPage extends StatefulWidget {
  final int articleTypeId;

  ArticleAddPage(this.articleTypeId);

  @override
  State<StatefulWidget> createState() => _ArticleAddPageState();
}

class _ArticleAddPageState extends State<ArticleAddPage> {
  bool initted = false;
  final toastService = getIt<ToastService>();
  Map properties = {};
  Map<String, TextEditingController> controllers = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticleAddBloc>(
        create: (ctx) {
          var bloc = ArticleAddBloc(
              articleTypeId: widget.articleTypeId,
              articleRepository: getIt(),
              articleTypeRepository: getIt(),
              companyRepository: getIt());

          bloc.add(ArticleAddLoadEvent());
          return bloc;
        },
        child: BlocConsumer<ArticleAddBloc, ArticleAddState>(
          listener: (context, state) {
            if (state.loading == false) {
              state.articleTypeProperties!.forEach((ArticleTypeProperty field) {
                if (field.type == 'company_inn') {
                  controllers['${field.slug}_name'] = TextEditingController();
                  controllers['${field.slug}_address'] =
                      TextEditingController();
                }
              });
              setState(() => initted = true);
            }
            if (state is ArticleAddSuccessState) {
              toastService.showSuccessToast(context,
                  S.of(context).addArticleScreenObjectSuccessfulCreatedMessage);
              Navigator.pushReplacementNamed(context, '/home');
            }
            if (state is ArticleAddFailureState) {
              toastService.showFailureToast(
                  context, S.of(context).networkException);
            }
          },
          builder: (context, state) {
            String title = '';
            List<Widget>? fields = <Widget>[];

            if (state.loading == false) {
              title = state.articleType!.name;

              fields = buildFields(context, state);
            }

            return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                title: Text(
                  title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 4, 20, 16),
                      child: BlocBuilder<ArticleAddBloc, ArticleAddState>(
                          builder: (context, state) {
                        // if (state is ArticleAddLoadState) {
                        //   return Center(child: CircularProgressIndicator());
                        // }

                        List<Widget> columnChildren = [];
                        if (state.loading == false) {
                          columnChildren = [
                            ...fields ?? [],
                            buildSaveButton(
                              context,
                              state,
                            ),
                          ];
                        }
                        return Column(
                          children: columnChildren,
                        );
                      })),
                ),
              ),
            );
          },
        ));
  }

  Container buildSaveButton(
    BuildContext context,
    ArticleAddState state,
  ) {
    var formNotFilled = state.articleTypeProperties!.any((field) =>
        field.required == true &&
        (properties[field.slug] == null || properties[field.slug] == ''));

    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: OutlinedButton(
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(
                    formNotFilled ? Color(0xff476EBE) : Color(0xff246BFD)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                )),
                //
              ),
              child: !state.sending
                  ? Text(
                      S.of(context).addArticleScreenCreate,
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
              onPressed: !state.sending
                  ? () {
                      BlocProvider.of<ArticleAddBloc>(context)
                          .add(ArticleAddStoreEvent(
                        articleType: state.articleType!,
                        articleTypeProperties: state.articleTypeProperties!,
                        properties: properties,
                      ));
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  List<Widget>? buildFields(BuildContext context, ArticleAddState state) {
    return state.articleTypeProperties!.map((ArticleTypeProperty field) {
      if (['text', 'big_text', 'number'].contains(field.type)) {
        return buildMyTextField(field, state);
      } else if (field.type == 'company_inn') {
        return buildCompanyInnFields(context, field, state);
      } else {
        return Text('Undefined field');
      }
    }).toList();
  }

  Container buildCompanyInnFields(
      BuildContext context, ArticleTypeProperty field, ArticleAddState state) {
    return Container(
      // padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              child: LabelTextWidget(
                  text: field.title, isRequired: field.required)),
          Container(
            decoration: BoxDecoration(
              color: properties['${field.slug}_name'] != null &&
                      properties['${field.slug}_name'] != ''
                  ? Color.fromRGBO(36, 107, 253, 0.08)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownSearch<Map>(
              compareFn: (item1, item2) =>
                  item1['data']['inn'] == item2['data']['inn'],
              popupProps: PopupProps.bottomSheet(
                  showSelectedItems: true,
                  showSearchBox: true,
                  isFilterOnline: true,
                  itemBuilder: (
                    BuildContext context,
                    Map item,
                    bool isSelected,
                  ) {
                    String inn = item['data']['inn'];
                    String name = item['value'];
                    String address = '';
                    if (item['data']?['address'] != null &&
                        item['data']?['address']?['value'] != null) {
                      address = item['data']['address']['value'];
                    }

                    return ListTile(
                      title: Text(inn),
                      subtitle: Text(name + "\r\n" + address),
                      textColor: isSelected ? Colors.blue : null,
                    );
                  },
                  emptyBuilder: (BuildContext context, String searchEntry) =>
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(searchEntry.length > 7
                              ? S
                                  .of(context)
                                  .addArticleScreenInnNotFoundSelectForFillManualy
                              : '')),
                  searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffDCDADA), width: 1.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )),
                  title: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Color(0xffE0E0E0),
                        indent: 175,
                        endIndent: 175,
                        thickness: 3,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 7),
                          child: Text(
                              (field.required == true ? 'Введите ' : '') +
                                  field.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start)),
                      Divider(
                        color: Color(0xffE0E0E0),
                        thickness: 1,
                      ),
                    ],
                  ),
                  // showSearchBox: true,
                  bottomSheetProps: BottomSheetProps(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  )),
              dropdownButtonProps: DropdownButtonProps(tooltip: "tooltip"),
              asyncItems: (String text) async {
                if (text.length <= 7) {
                  return [];
                }
                DadataService dadataService = getIt.get<DadataService>();

                var items;

                try {
                  var response = await dadataService.findPartyById(text);
                  items = jsonDecode(response.body);
                } catch (_) {
                  items = {'suggestions': []};
                }
                // 7725396754

                return items['suggestions'].length > 0
                    ? (items['suggestions'] as List<dynamic>)
                        .cast<Map<dynamic, dynamic>>()
                        .toList()
                    : [
                        {
                          'data': {
                            'inn': text,
                            'address': {'value': ''}
                          },
                          'value': '',
                        }
                      ];
              },
              clearButtonProps: ClearButtonProps(
                  icon: Icon(Icons.clear, size: 22, color: Colors.black26)),
              itemAsString: (item) => item['data']['inn'],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: properties[field.slug] != null &&
                          properties[field.slug].length > 0
                      ? null
                      : 'ИНН',
                  labelStyle: TextStyle(
                      color: properties[field.slug] != null &&
                              properties[field.slug] != ''
                          ? Colors.black
                          : Color(0xff9E9E9E),
                      fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: properties[field.slug] != null &&
                                properties[field.slug] != ''
                            ? Color(0xff246BFD)
                            : Color(0xffDCDCDC),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: properties[field.slug] != null &&
                                properties[field.slug] != ''
                            ? Color(0xff246BFD)
                            : Color(0xffDCDCDC),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onChanged: (value) => setState(() {
                Map mapValue = value as Map;

                String inn = mapValue['data']['inn'];
                String name = mapValue['value'];
                String address = '';
                if (mapValue['data']?['address'] != null &&
                    mapValue['data']?['address']?['value'] != null) {
                  address = mapValue['data']['address']['value'];
                }

                state.errors['properties.${field.slug}']?.clear();

                properties[field.slug] = inn;
                properties['${field.slug}_name'] =
                    controllers['${field.slug}_name']?.text = name;
                properties['${field.slug}_address'] =
                    controllers['${field.slug}_address']?.text = address;
              }),
            ),
          ),
          if (state.errors.containsKey('properties.${field.slug}'))
            Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                        state.errors['properties.${field.slug}']?.join('\r\n'),
                        style: TextStyle(color: Colors.red)))),

          Container(
              alignment: Alignment.centerLeft,
              child: LabelTextWidget(
                  text: 'Название компании', isRequired: field.required)),
          CustomTextField(
            hintText: 'Название компании',
            controller: controllers["${field.slug}_name"]!,
            onChanged: (str) => setState(() {
              properties['${field.slug}_name'] = str;
              state.errors['properties.${field.slug}_name']?.clear();
            }),
          ),
          if (state.errors.containsKey('properties.${field.slug}_name'))
            Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                        state.errors['properties.${field.slug}_name']
                            ?.join('\r\n'),
                        style: TextStyle(color: Colors.red)))),

          //Padding(padding: EdgeInsets.only(top: 24)),
          Container(
              alignment: Alignment.centerLeft,
              child: LabelTextWidget(
                  text: 'Адрес компании', isRequired: field.required)),
          CustomTextField(
            hintText: 'Адрес компании',
            controller: controllers["${field.slug}_address"]!,
            onChanged: (str) => setState(() {
              properties["${field.slug}_address"] = str;
              state.errors['properties.${field.slug}_address']?.clear();
            }),
          ),
          if (state.errors.containsKey('properties.${field.slug}_address'))
            Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                        state.errors['properties.${field.slug}_address']
                            ?.join('\r\n'),
                        style: TextStyle(color: Colors.red)))),
        ],
      ),
    );
  }

  Widget buildMyTextField(ArticleTypeProperty field, ArticleAddState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextWidget(text: field.title, isRequired: field.required),
        CustomTextField(
          hintText: S.of(context).fillInTheField,
          minLines: field.type == 'big_text' ? 3 : 1,
          maxLines: field.type == 'big_text' ? 5 : 3,
          keyboardType:
              field.type == 'number' ? TextInputType.phone : TextInputType.text,
          inputFormatters: field.type == 'number'
              ? [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))]
              : [],
          controller: controllers[field.slug],
          onChanged: (value) => setState(() {
            properties[field.slug] = value;
            state.errors['properties.${field.slug}']?.clear();
          }),
        ),
        if (state.errors.containsKey('properties.${field.slug}'))
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                  state.errors['properties.${field.slug}']?.join('\r\n'),
                  style: TextStyle(color: Colors.red))),
      ],
    );
  }

  String wordwrap(String str, {int width = 70, String breakSymbol = '\n'}) {
    List<String> words = str.split(' ');
    int rowLength = 0;
    String newStr = words.reduce((value, element) {
      if (rowLength >= width) {
        value += '\n';
        rowLength = 0;
      } else {
        value += ' ';
      }
      value += element;
      rowLength += element.length + 1;
      return value;
    });
    return newStr.trim();
  }
}
