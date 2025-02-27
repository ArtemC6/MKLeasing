import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';
import 'package:leasing_company/features/camera/presentation/compressing_page/bloc/compressing_video_bloc.dart';
import 'package:leasing_company/features/camera/presentation/compressing_page/widgets/video_compressing_item.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:video_compress/video_compress.dart';

class CompressingVideoPage extends StatefulWidget {
  final List<MediaFileModel> mediaFiles;

  CompressingVideoPage({
    Key? key,
    required this.mediaFiles,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CompressingVideoPageState();
}

class _CompressingVideoPageState extends State<CompressingVideoPage> {
  late final CompressingVideoBloc _bloc;
  final compressingFileIndex = ValueNotifier(0);
  late final Subscription compressSubscription;
  final log = Logger('CompressingVideoPageLogger');

  @override
  void initState() {
    super.initState();
    compressSubscription =
        VideoCompress.compressProgress$.subscribe((progress) {
      _bloc.add(UpdateProgressEvent(progress: progress));
    });
    _startCompressing();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            S.of(context).videoProcessing,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocProvider<CompressingVideoBloc>(
          create: (BuildContext context) {
            _bloc = CompressingVideoBloc();
            return _bloc;
          },
          child: BlocBuilder<CompressingVideoBloc, CompressingVideoState>(
              builder: (context, state) {
            if (state.compressingVideoIndex == widget.mediaFiles.length) {
              Future.delayed(Duration(milliseconds: 300))
                  .then((value) => Navigator.pop(context, widget.mediaFiles));
            }
            if (widget.mediaFiles.isEmpty) {
              try {
                throw Exception('Compressing video page Exception');
              } catch (error, stackTrace) {
                log.info('CompressingVideoPage: _CompressingVideoPageState');
                log.severe(
                    'widget.mediaFiles.isEmpty = ${widget.mediaFiles.isEmpty}',
                    error,
                    stackTrace);
              }
            }
            return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: widget.mediaFiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  if (widget.mediaFiles[index].stepFile?.path == null) {
                    try {
                      throw Exception('Compressing video page Exception');
                    } catch (error, stackTrace) {
                      log.info(
                          'CompressingVideoPage: _CompressingVideoPageState');
                      log.severe(
                          'widget.mediaFiles[index].stepFile?.path = ${widget.mediaFiles[index].stepFile?.path}',
                          error,
                          stackTrace);
                    }
                  }
                  return VideoCompressingItem(
                    mediaFile: widget.mediaFiles[index],
                    isCompressed: state.compressingVideoIndex > index,
                    percents: state.compressingVideoIndex == index
                        ? state.percents
                        : 0,
                  );
                });
          }),
        ),
      ),
    );
  }

  Future<void> _startCompressing() async {
      try {
        for (MediaFileModel mediaFile in widget.mediaFiles) {
          try {
            MediaInfo? mediaInfo = await VideoCompress.compressVideo(
            mediaFile.stepFile!.path!,
            quality: VideoQuality.DefaultQuality,
            deleteOrigin: true,
            includeAudio: true,
          );
          log.info('mediaFile.stepFile?.path = ${mediaFile.stepFile?.path}');
            await File(mediaInfo!.path!).copy(mediaFile.stepFile!.path!);
          } catch (exception, stackTrace) {
            log.info(
                'CompressingVideoPage: _CompressingVideoPageState._startCompressing');
            log.info('mediaFile.stepFile?.path = ${mediaFile.stepFile?.path}');
            await Sentry.captureException(
              exception,
              stackTrace: stackTrace,
            );
          }
          VideoCompress.deleteAllCache();
          _bloc.add(VideoCompressedEvent());
        }
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }
  }
    @override
    void dispose() {
      compressSubscription.unsubscribe();
      VideoCompress.dispose();
      super.dispose();
    }
  }

