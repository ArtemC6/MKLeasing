import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_field.dart';
import 'package:leasing_company/generated/l10n.dart';

class ReviewCopySectionPage extends StatefulWidget {
  final ReviewSection section;

  const ReviewCopySectionPage({Key? key, required this.section})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewCopySectionPageState();
}

class _ReviewCopySectionPageState extends State<ReviewCopySectionPage> {
  bool isNeedToShowValidateResult = false;
  String sectionName = '';
  int numberOfCopies = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Text(S.of(context).copyingSection),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Row(children: [
                  SvgPicture.asset(
                    'assets/icons/instruction.svg',
                    height: 26,
                    width: 26,
                  ),
                  SizedBox(width: 8),
                  Text(
                    S.of(context).instruction,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ]),
                SizedBox(height: 10),
                Text(S.of(context).copyingSectionInstruction),
                SizedBox(height: 16),
                _buildInfoRow(1, S.of(context).enterNewSectionName),
                SizedBox(height: 8),
                _buildInfoRow(2, S.of(context).youCanSpecifyNameCopiedSteps),
                SizedBox(height: 20),
                Image.asset(
                    'assets/images/reviews/change_step_name_example.png'),
                SizedBox(height: 20),
                Text(
                  S.of(context).sectionName + ':',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                SizedBox(height: 6),
                CustomTextField(
                  hintText: S.of(context).fillInTheField,
                  maxLength: 150,
                  isValueValid: isNeedToShowValidateResult
                      ? sectionName.isNotEmpty
                      : true,
                  isCounterVisible: true,
                  onChanged: (value) {
                    setState(() {
                      sectionName = value;
                    });
                  },
                ),
                SizedBox(height: 26),
                CustomOutlinedButton(
                    text: S.of(context).toNextStepButtonTitle,
                    backgroundColor: Color(0xFF246BFD),
                    onPressed: () {
                      if (sectionName.isNotEmpty) {
                        final newSection = widget.section.copyWith(
                          title: sectionName,
                          parentId: drift.Value(
                            widget.section.isSelfCreated
                                ? widget.section.id
                                : widget.section.remoteId,
                          ),
                        ); //
                        Navigator.of(context).pop(newSection);
                      } else {
                        setState(() {
                          isNeedToShowValidateResult = true;
                        });
                      }
                    }),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(int index, String text) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF246BFD),
          ),
          padding: EdgeInsets.all(6),
          child: Text(
            index.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          )),
      SizedBox(width: 8),
      Expanded(child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(text),
      )),
    ]);
  }
}
