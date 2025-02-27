import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/preview_photo/presentation/preview_photo/bloc/preview_photo_bloc.dart';
import 'package:leasing_company/features/preview_photo/presentation/preview_photo/bloc/preview_photo_event.dart';
import 'package:leasing_company/features/preview_photo/presentation/preview_photo/bloc/preview_photo_state.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/features/preview_photo/presentation/preview_photo/widgets/video_player_widget.dart';
import 'package:mime/mime.dart';


class PreviewPhotoPage extends StatefulWidget {
  ReviewStepFileDTO stepFileDTO;
  final MakeReportBloc makeReportBloc;
  final bool onlyPreview;
  final String? title;

  PreviewPhotoPage({
    required this.makeReportBloc,
    required this.stepFileDTO,
    required this.onlyPreview,
    this.title,
  });

  @override
  State<StatefulWidget> createState() => PreviewPhotoPageState();
}

class PreviewPhotoPageState extends State<PreviewPhotoPage> {
  TextEditingController commentController = TextEditingController();
  PreviewPhotoBloc? bloc;

  @override
  void initState() {
    super.initState();
    commentController.text = widget.stepFileDTO.comment ?? "";
    commentController.addListener(() {
      widget.stepFileDTO.comment = commentController.text;
      if (widget.stepFileDTO.fileUuid != null) {
        widget.makeReportBloc.add(MakeReportChangeMediaCommentEvent(
            fileUuid: widget.stepFileDTO.fileUuid!,
            comment: commentController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreviewPhotoBloc(),
      child: BlocConsumer<PreviewPhotoBloc, PreviewPhotoState>(
        listener: (context, state) {
          if (state is ApplyState) {
            Navigator.pop(context, this.widget.stepFileDTO);
          }
          if (state is DenyState) {
            Navigator.pop(context, false);
          }
        },
        builder: (BuildContext context, PreviewPhotoState state) {
          if (bloc == null) {
            bloc = context.read<PreviewPhotoBloc>();
          }
          if (state is PreviewPhotoInitial) {
            List<Widget> stackChildren = [];

            String? mimeType = lookupMimeType(widget.stepFileDTO.path!);

            if (mimeType?.startsWith('image/') == true) {
              // image
              stackChildren
                  .add(Image.file(File(this.widget.stepFileDTO.path!)));
            } else if (mimeType?.startsWith('video/') == true) {
              // video
              stackChildren
                  .add(VideoPlayerWidget(this.widget.stepFileDTO.path!));
            } else {
              stackChildren.add(
                  Text(S.of(context).previewPhotoScreenUnexpectedFileFormat));
            }

            var chooseButtons = [];

            if (this.widget.onlyPreview == false) {
              chooseButtons.add(Container(
                color: Colors.black54,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: FloatingActionButton(
                        heroTag: "deny",
                        onPressed: () =>
                            context.read<PreviewPhotoBloc>().add(DenyEvent()),
                        child: Icon(Icons.block, color: Colors.white),
                        backgroundColor: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: FloatingActionButton(
                        heroTag: "apply",
                        onPressed: () =>
                            context.read<PreviewPhotoBloc>().add(ApplyEvent()),
                        child: Icon(Icons.done, color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ));
            }

            stackChildren.add(Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextField(
                            controller: commentController,
                            style: TextStyle(color: Colors.white),
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black54,
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              hintText:
                                  S.of(context).previewPhotoScreenEnterComment,
                              counterStyle: TextStyle(color: Colors.white),
                              helperStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white),
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                          ...chooseButtons,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));

            return Scaffold(
              appBar: this.widget.onlyPreview
                  ? AppBar(
                      title: Text(
                        this.widget.title != null ? this.widget.title! : '',
                        style: TextStyle(
                          color: Color(0xff212121),
                        ),
                      ),
                      elevation: 0,
                      iconTheme: IconThemeData(
                        color: Color(0xff212121),
                      ),
                      backgroundColor: Color(0xffF6FAFD),
                    )
                  : null,
              backgroundColor: Colors.white,
              body: Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.center,
                    children: stackChildren,
                  )),
            );
          }
          if (state is ApplyState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DenyState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Container(
              child: Text('error'),
            ),
          );
        },
      ),
    );
  }
}
