import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/make_document/presentation/make_document/bloc/make_document_bloc.dart';
import 'package:leasing_company/features/make_document/presentation/make_document/bloc/make_document_event.dart';
import 'package:leasing_company/features/make_document/presentation/make_document/bloc/make_document_state.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/features/preview_photo/presentation/preview_photo/page/preview_photo_page.dart';
import 'package:leasing_company/services/file_hash_service.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';


class MakeDocumentPage extends StatefulWidget {
  final ReviewTemplateStepModel step;
  final MakeReportBloc makeReportBloc;

  const MakeDocumentPage({required this.step, required this.makeReportBloc});

  @override
  State<MakeDocumentPage> createState() => _MakeDocumentPageState();
}

class _MakeDocumentPageState extends State<MakeDocumentPage> {
  final FileHashService fileHashService = getIt();
  MakeDocumentBloc? bloc;

  @override
  Widget build(BuildContext context) {
    S strings = S.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (BuildContext context) => MakeDocumentBloc(
          widget.step,
          widget.makeReportBloc,
          strings,
          fileHashService,
        ),
        child: BlocConsumer<MakeDocumentBloc, MakeDocumentState>(
          listener: (context, state) async {
            if (state is MakeDocumentToPreviewPhoto) {
              var accepted = await Navigator.push(
                this.context,
                MaterialPageRoute(
                  builder: (context) => PreviewPhotoPage(
                    makeReportBloc: widget.makeReportBloc,
                    stepFileDTO: state.stepFileDTO,
                    onlyPreview: false,
                  ),
                ),
              );
              if (accepted is ReviewStepFileDTO) {
                state.stepFileDTO.comment = accepted.comment;
                Navigator.pop(this.context, state.stepFileDTO);
              } else {
                await File(join(await getStorageDir(),
                        basename(state.stepFileDTO.path!)))
                    .delete();
                if (state.stepFileDTO.compressedPath != null) {
                  await File(join(await getCompressedStorageDir(),
                          basename(state.stepFileDTO.compressedPath!)))
                      .delete();
                }
                context.read<MakeDocumentBloc>().add(InitializeEvent());
              }
            }
            if (state is InitializeError) {
              Navigator.pop(this.context, null);
            }
            if (state is ExitState) {
              Navigator.pop(this.context, null);
            }
          },
          builder: (BuildContext context, MakeDocumentState state) {
            if (bloc == null) {
              bloc = context.read<MakeDocumentBloc>();
            }
            if (state is InitializeError) {
              return Scaffold(
                body: Center(
                  child: Text('Произошла ошибка'),
                ),
              );
            }
            if (state is MakeDocumentHaveNotLocationPermission) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 17, right: 33, bottom: 27),
                        child: Text(
                          S.of(context).makeReportPageHaveNotLocationPermission,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side:
                                BorderSide(color: Colors.transparent, width: 0),
                            padding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xffE9F0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )),
                        child: Text(
                          S.of(context).makeMediaPageOpenAppSettings,
                          style: TextStyle(
                              color: Color(0xff246BFD),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: openAppSettings,
                      )
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
