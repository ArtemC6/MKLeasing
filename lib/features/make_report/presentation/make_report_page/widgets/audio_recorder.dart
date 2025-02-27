import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/core/managers/permission_manager.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_multimedia_model.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecorderWidget extends StatefulWidget {
  final int? stepId;
  final ReviewTemplateStepMultimediaModel multimediaModel;

  const AudioRecorderWidget({
    Key? key,
    required this.stepId,
    required this.multimediaModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorderWidget> {
  final _record = Record();
  late final StreamSubscription _onStateChanged;
  Stream? _audioRecordingTimer;
  int _audioDuration = 0;
  RecorderState? _currentRecorderState = RecorderState.waitRecording;
  bool _isAudioRecording = false;
  bool _isHavePermission = false;
  List<double> _audioTrack = [];
  String _audioFilePath = '';
  late final minDuration = widget.multimediaModel.minDuration ?? 0;
  late final maxDuration = widget.multimediaModel.maxDuration != null
      ? widget.multimediaModel.maxDuration == 0
          ? 600
          : widget.multimediaModel.maxDuration!
      : 600;

  @override
  void initState() {
    super.initState();
    _onStateChanged = _record.onStateChanged().listen((event) {
      switch (event) {
        case RecordState.pause:
          _currentRecorderState = RecorderState.paused;
          break;
        case RecordState.record:
          _currentRecorderState = RecorderState.recording;
          break;
        case RecordState.stop:
          _currentRecorderState = RecorderState.recordedAudio;
      }
      if (event == RecordState.record) {
        _audioRecordingTimer = Stream.periodic(Duration(seconds: 1), (timer) async {
          _audioDuration++;
          if (_audioDuration == maxDuration) {
            await _record.stop();
            _isAudioRecording = false;
            _audioRecordingTimer = null;
            _currentRecorderState = RecorderState.recordedAudio;
            setState(() {});
          }
          return timer;
        });
      } else {
        _audioRecordingTimer = null;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    _record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isHavePermission) {
      getIt<PermissionManager>().checkPermissions(context, permissions: [
        Permission.microphone,
      ]).then((isHaveMicroPermission) => setState(() {
            _isHavePermission = isHaveMicroPermission;
          }));
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _isHavePermission
          ? Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(height: 10),
              Text(S.of(context).audioRecording,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(height: 16),
              Text(S.of(context).audioRecordingRestrictions(
                    minDuration.toString(),
                    maxDuration.toString(),
                  )),
              SizedBox(height: 16),
              SvgPicture.asset(
                'assets/icons/audio.svg',
                color: _isAudioRecording &&
                        _currentRecorderState == RecorderState.recording
                    ? Color(0xFFF64E60)
                    : Color(0xFF89B5FC),
                height: 45,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: _currentRecorderState != RecorderState.recordedAudio
                    ? Row(children: [
                        Expanded(
                            child: StreamBuilder(
                                stream: _record.onAmplitudeChanged(Duration(milliseconds: 250)),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    final percent =
                                        (snapshot.data!).max /
                                            (snapshot.data!).current;
                                    _audioTrack.add(percent);
                                  }
                                  return SingleChildScrollView(
                                    reverse: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: _audioTrack
                                          .mapIndexed((index, element) =>
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0.6),
                                                width: 2,
                                                height: 60 * element > 5
                                                    ? 60 * element
                                                    : 4,
                                                decoration: BoxDecoration(
                                                  color:
                                                      _audioTrack.length - 1 ==
                                                              index
                                                          ? Color(0xFFF64E60)
                                                          : Color(0xFF89B5FC),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  );
                                })),
                        Expanded(child: SizedBox())
                      ])
                    : Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                reverse: true,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: _audioTrack
                                      .mapIndexed((index, element) => Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 0.7),
                                            width: 2,
                                            height: 60 * element > 5
                                                ? 60 * element
                                                : 4,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF89B5FC),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
              SizedBox(height: 16),
              StreamBuilder(
                stream: _audioRecordingTimer,
                builder: (context, snapshot) {
                  final sec = _audioDuration % 60;
                  final min = (_audioDuration / 60).floor();
                  final durationStr = min.toString().padLeft(2, "0") +
                      ":" +
                      sec.toString().padLeft(2, "0");
                  return Text(
                    durationStr,
                    style: TextStyle(
                      color: _isAudioRecording ||
                              _currentRecorderState ==
                                  RecorderState.recordedAudio
                          ? Colors.black
                          : Color(0xFFD0D0D0),
                      fontSize: 18,
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    if (_currentRecorderState == RecorderState.recordedAudio) {
                      _audioTrack = [];
                      _currentRecorderState = RecorderState.waitRecording;
                      _audioDuration = 0;
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFD9D9D9), width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.delete,
                        color:
                            _currentRecorderState != RecorderState.recordedAudio
                                ? Color(0xFFD9D9D9)
                                : Colors.black,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  highlightColor: Colors.white.withOpacity(0.2),
                  splashColor: Colors.white.withOpacity(0.2),
                  onTap: () async {
                    if (_currentRecorderState == RecorderState.recording ||
                        _currentRecorderState == RecorderState.paused) {
                      if (_audioDuration < minDuration) {
                        getIt<ToastService>().showFailureToast(
                          context,
                          S.of(context).minimumAudioLengthNotReached,
                        );
                        return;
                      }
                      await _record.stop();
                      _isAudioRecording = false;
                      _audioRecordingTimer = null;
                      _currentRecorderState = RecorderState.recordedAudio;
                    } else if (_currentRecorderState ==
                        RecorderState.waitRecording) {
                      _isAudioRecording = true;
                      _audioFilePath = await getStorageDir() +
                          '/${DateTime.now().millisecondsSinceEpoch}.m4a';
                      await _record.start(path: _audioFilePath);
                      await Future.delayed(Duration(seconds: 1));
                    }
                    setState(() {});
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFD9D9D9), width: 2),
                    ),
                    width: 57,
                    height: 57,
                    child: Padding(
                      padding: EdgeInsets.all(_isAudioRecording ? 10 : 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: _isAudioRecording
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          color: _currentRecorderState !=
                                  RecorderState.recordedAudio
                              ? Color(0xFFF64E60)
                              : Color(0xFFD9D9D9),
                          borderRadius: _isAudioRecording
                              ? BorderRadius.circular(8)
                              : null,
                        ),
                        height: _isAudioRecording ? 33 : 45,
                        width: _isAudioRecording ? 33 : 45,
                        //duration: Duration(milliseconds: 400),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    if (_currentRecorderState == RecorderState.paused) {
                      _record.resume();
                      _audioRecordingTimer =
                          Stream.periodic(Duration(seconds: 1), (timer) {
                        _audioDuration++;
                      });
                    }
                    if (_currentRecorderState == RecorderState.recording) {
                      _record.pause();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFD9D9D9), width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        _currentRecorderState == RecorderState.paused
                            ? Icons.play_arrow
                            : Icons.pause,
                        color: _isAudioRecording
                            ? Colors.black
                            : Color(0xFFD9D9D9),
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 24),
              Row(children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      _record.dispose();
                      Navigator.of(context).pop();
                    },
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
                    onTap: _currentRecorderState != RecorderState.recordedAudio
                        ? null
                        : () async {
                            final String? fileName =
                                await getIt<DialogManager>()
                                    .showAudioNameDialog(context);
                            if (fileName != null) {
                              String bname = basenameWithoutExtension(_audioFilePath);

                              String newPathWithName = join(
                                await getStorageDir(),
                                '$bname.$fileName.m4a',
                              );

                              await File(_audioFilePath).rename(
                                  join(
                                    await getStorageDir(),
                                    '$bname.$fileName.m4a',
                                  )
                              );
                              DateTime onDeviceCreatedAt = DateTime.now();
                              final stepFile = ReviewStepFileDTO(
                                stepId: widget.stepId,
                                type: StepContentType.audio.name,
                                path: newPathWithName,
                                onDeviceCreatedAt: onDeviceCreatedAt,
                                createdAt: onDeviceCreatedAt.toUtc(),
                              );
                              Navigator.of(context).pop(stepFile);
                            }
                          },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Color(0xFF00A3FF).withOpacity(
                            _currentRecorderState != RecorderState.recordedAudio
                                ? 0.5
                                : 1),
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
            ])
          : SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
            ),
    );
  }
}

enum RecorderState {
  waitRecording,
  recording,
  paused,
  recordedAudio,
}
