import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';
import 'package:leasing_company/features/camera/presentation/media_preview_page/bloc/media_preview_page_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewWidget extends StatefulWidget {
  final MediaFileModel mediaFile;
  final bool videoOrientationIsPortrait;

  const VideoPreviewWidget({
    Key? key,
    required this.mediaFile,
    required this.videoOrientationIsPortrait,
  }) : super(key: key);

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  late final _videoController = VideoPlayerController.file(
      File(widget.mediaFile.stepFile!.path!)
  );
  bool isPlayingMode = false;
  bool isVideoPlaying = false;
  bool isLandscape = false;
  bool isNeedToShowVideoMenu = true;
  bool isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _videoController.initialize().then((_) {
      setState(() {});
    });
    initVideoControllerListener();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isPlayingMode) {
          setState(() {
            isNeedToShowVideoMenu = !isNeedToShowVideoMenu;
          });
        }
      },
      child: widget.mediaFile.isSaved
          ? Stack(children: [
              _videoController.value.isInitialized
                  ? Center(
                      child: widget.videoOrientationIsPortrait
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: _videoController.value.size.width,
                              child: VideoPlayer(
                                _videoController,
                              ),
                            )
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                height: _videoController.value.size.height,
                                width: _videoController.value.size.width,
                                child: AspectRatio(
                                  aspectRatio:
                                      _videoController.value.aspectRatio,
                                  child: VideoPlayer(
                                    _videoController,
                                  ),
                                ),
                              ),
                            ),
                    )
                  : Center(child: CircularProgressIndicator()),
              Visibility(
                visible: !isPlayingMode,
                child: Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      isButtonPressed = true;
                      _videoController.play();
                    },
                    child: Icon(
                      Icons.play_circle,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: isPlayingMode && isNeedToShowVideoMenu ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    SizedBox(height: 6),
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            highlightColor: Colors.white38,
                            splashColor: Colors.white54,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Ink(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isButtonPressed = true;
                            if (isVideoPlaying) {
                              _videoController.pause();
                            } else {
                              _videoController.play();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 18,
                              right: 8,
                              top: 4,
                              bottom: 6,
                            ),
                            child: Icon(
                              isVideoPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 1.8,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 8),
                                ),
                                child: Slider(
                                  activeColor: Colors.white,
                                  thumbColor: Colors.white,
                                  inactiveColor: Colors.white60,
                                  value: _videoController
                                      .value.position.inMilliseconds
                                      .toDouble(),
                                  max: _videoController
                                      .value.duration.inMilliseconds
                                      .toDouble(),
                                  onChanged: (value) {
                                    _videoController.seekTo(
                                        Duration(milliseconds: value.toInt()));
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 20.0),
                                  Text(
                                    format(_videoController.value.position),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(child: SizedBox.shrink()),
                                  Text(
                                    format(_videoController.value.duration),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 20.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<MediaPreviewPageBloc>()
                                .add(ChangedOrientationEvent(
                                  !isLandscape,
                                ));
                            SystemChrome.setPreferredOrientations(
                              isLandscape
                                  ? [DeviceOrientation.portraitUp]
                                  : [
                                      DeviceOrientation.landscapeLeft,
                                      DeviceOrientation.landscapeRight,
                                    ],
                            );
                            isLandscape = !isLandscape;
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 18,
                              top: 4,
                              bottom: 6,
                            ),
                            child: Icon(
                              Icons.screen_rotation,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ])
          : Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _videoController.dispose();
    super.dispose();
  }

  String format(Duration duration) {
    final timeStr = duration.toString().split('.').first;
    return timeStr.replaceRange(0, timeStr.indexOf(':') + 1, '');
  }

  void initVideoControllerListener() {
    _videoController.addListener(() {
      if (mounted) {
        if (_videoController.value.position ==
            _videoController.value.duration) {
          isPlayingMode = false;
          isVideoPlaying = false;
          _videoController.seekTo(Duration(milliseconds: 0));
          context.read<MediaPreviewPageBloc>().add(ShowAppBarAndCommentEvent());
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          setState(() {});
        }
        if (!_videoController.value.isPlaying &&
            isPlayingMode &&
            isButtonPressed) {
          setState(() {
            isVideoPlaying = false;
            isButtonPressed = false;
          });
        } else if (_videoController.value.isPlaying &&
            isPlayingMode &&
            isButtonPressed) {
          setState(() {
            isVideoPlaying = true;
            isButtonPressed = false;
          });
        } else if (isButtonPressed && !isPlayingMode) {
          setState(() {
            isPlayingMode = true;
            isVideoPlaying = true;
            isButtonPressed = false;
            context
                .read<MediaPreviewPageBloc>()
                .add(HideAppBarAndCommentEvent());
          });
          hideVideoMenu();
        } else {
          setState(() {});
        }
      }
    });
  }

  void hideVideoMenu() async {
    await Future.delayed(Duration(seconds: 4));
    isNeedToShowVideoMenu = false;
  }
}
