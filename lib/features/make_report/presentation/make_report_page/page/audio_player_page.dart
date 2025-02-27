import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';

class AudioPlayerPage extends StatefulWidget {
  final ReviewStepFile stepFile;
  final Function(String, String) onChangedComment;
  final Function(ReviewStepFile) onDelete;

  const AudioPlayerPage({
    Key? key,
    required this.stepFile,
    required this.onChangedComment,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  final _audioPlayer = AudioPlayer();
  final _textController = TextEditingController();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late ReviewStepFile currentStepFile = widget.stepFile;

  @override
  void initState() {
    super.initState();
    _audioPlayer.setFilePath(widget.stepFile.path!).then((value) {
      if (value != null) {
        setState(() {
          duration = value;
        });
      }
    });
    _audioPlayer.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
          _audioPlayer.stop();
          _audioPlayer.seek(Duration(milliseconds: 0));
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return duration != Duration.zero
        ? GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color(0xffF64E60),
                    ),
                    onPressed: () async {
                      final isNeedToDelete =
                          await getIt<DialogManager>().showOnDeleteDialog(
                        context,
                        S.of(context).taskExecutionDeleteFileDialogContent,
                      );
                      if (isNeedToDelete == true) {
                        widget.onDelete(currentStepFile);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Center(
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.stepFile.path!.substring(
                                    widget.stepFile.path!.lastIndexOf('/') + 1,
                                    widget.stepFile.path!.lastIndexOf('.')),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 32),
                              SvgPicture.asset(
                                'assets/icons/audio.svg',
                                color: Color(0xFF246BFD),
                                height: 60,
                              ),
                              SizedBox(height: 24),
                              StreamBuilder(
                                  stream: _audioPlayer.positionStream,
                                  builder: (context, snapshot) {
                                    Duration position = snapshot.data != null
                                        ? snapshot.data as Duration
                                        : Duration.zero;
                                    if (position.inMilliseconds >
                                        duration.inMilliseconds) {
                                      position = duration;
                                    }
                                    return Slider(
                                      min: 0,
                                      max: duration.inMilliseconds.toDouble(),
                                      value: position.inMilliseconds.toDouble(),
                                      activeColor: Color(0xFF246BFD),
                                      inactiveColor: Color(0xFFE2E2E2),
                                      onChanged: (value) {
                                        setState(() {
                                          _audioPlayer.seek(Duration(
                                              milliseconds: value.toInt()));
                                          //position = Duration(seconds: value.toInt());
                                        });
                                      },
                                    );
                                  }),
                              StreamBuilder(
                                stream: _audioPlayer.positionStream,
                                builder: (context, snapshot) {
                                  final position = snapshot.data != null
                                      ? snapshot.data as Duration
                                      : Duration.zero;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('mm:ss').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              position.inMilliseconds,
                                            ),
                                          ),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          DateFormat('mm:ss').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              duration.inMilliseconds,
                                            ),
                                          ),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              CircleAvatar(
                                radius: 26,
                                backgroundColor: Color(0xFF246BFD),
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  iconSize: 34,
                                  onPressed: () {
                                    if (isPlaying) {
                                      _audioPlayer.pause();
                                      isPlaying = false;
                                    } else {
                                      isPlaying = true;
                                      _audioPlayer.play();
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!(currentStepFile.comment != null &&
                      currentStepFile.comment!.isNotEmpty))
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 2, 20, 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(3),
                      child: TextField(
                        controller: _textController,
                        //focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        maxLength: 255,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        minLines: 1,
                        maxLines: 3,
                        onSubmitted: (text) => onCommentSaved(text),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.fromLTRB(16, 8, 6, 8),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              onCommentSaved(_textController.text);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.send,
                                color: Color(0xFF246BFD),
                              ),
                            ),
                          ),
                          hintText:
                              S.of(context).previewPhotoScreenEnterComment,
                          hintStyle: TextStyle(fontSize: 15),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE1E0E0)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE1E0E0)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE1E0E0)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE1E0E0)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              floatingActionButton: currentStepFile.comment != null &&
                      currentStepFile.comment!.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                            ),
                            builder: (modalContext) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 37),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 3,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE0E0E0),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      SizedBox(width: 12),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          onCommentSaved('');
                                          Navigator.of(modalContext).pop();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Icon(
                                              Icons.delete_outline,
                                              size: 24,
                                              color: Color(0xFFF75555),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          currentStepFile.comment!,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                    ],
                                  ),
                                  SizedBox(height: 34),
                                ],
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 6),
                        height: 64,
                        width: 62,
                        child: Stack(
                          children: [
                            Container(
                              height: 54,
                              width: 54,
                              margin: EdgeInsets.only(top: 10, left: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.75),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/comment.svg',
                                  height: 26,
                                  width: 26,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Color(0xFF246BFD),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void onCommentSaved(String newComment) {
    _textController.text = '';
    currentStepFile =
        currentStepFile.copyWith(comment: drift.Value(newComment));
    widget.onChangedComment(currentStepFile.uuid, currentStepFile.comment!);
    setState(() {});
  }
}
