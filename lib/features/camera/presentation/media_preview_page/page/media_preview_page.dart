import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/camera_mode.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/media_file_model.dart';
import 'package:leasing_company/features/camera/presentation/media_preview_page/bloc/media_preview_page_bloc.dart';
import 'package:leasing_company/features/camera/presentation/media_preview_page/widgets/photo_preview_widget.dart';
import 'package:leasing_company/features/camera/presentation/media_preview_page/widgets/video_preview_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

class MediaPreviewPage extends StatefulWidget {
  final List<MediaFileModel> mediaFiles;
  final int initialIndex;
  final Function(MediaFileModel) onDelete;
  final Function(int, String) onChangedComment;
  final bool isOpenedFromCamera;

  const MediaPreviewPage({
    Key? key,
    required this.mediaFiles,
    required this.initialIndex,
    required this.onDelete,
    required this.onChangedComment,
    this.isOpenedFromCamera = false,
  }) : super(key: key);

  @override
  State<MediaPreviewPage> createState() => _MediaPreviewPageState();
}

class _MediaPreviewPageState extends State<MediaPreviewPage> {
  List<MediaFileModel> mediaFiles = [];
  late final TextEditingController _textController;
  late final ExtendedPageController _pageController;
  late final MediaPreviewPageBloc _bloc;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    mediaFiles = widget.mediaFiles;
    _textController = TextEditingController(
      text: widget.mediaFiles[widget.initialIndex].stepFile?.comment,
    );
    _pageController = ExtendedPageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    if (widget.isOpenedFromCamera == false) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
      ));
    }
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black,
      ));
    });
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        onCommentSaved(_textController.text);
        return true;
      },
      child: BlocProvider(
        create: (context) {
          _bloc = MediaPreviewPageBloc(widget.initialIndex, mediaFiles);
          _bloc.add(InitialEvent());
          return _bloc;
        },
        child: BlocBuilder<MediaPreviewPageBloc, MediaPreviewPageState>(
          builder: (context, state) {
            final String? comment =
                mediaFiles[state.mediaFileIndex].stepFile?.comment;
            return SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: !state.isPageLoading
                    ? Scaffold(
                        backgroundColor: Colors.black,
                        extendBodyBehindAppBar: true,
                        floatingActionButton: comment != null &&
                                comment.isNotEmpty &&
                                !state.isPlayingVideoMode
                            ? GestureDetector(
                                onTap: () =>
                                    _showCommentBottomSheet(context, comment),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 6),
                                  height: 64,
                                  width: 62,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 54,
                                        width: 54,
                                        margin:
                                            EdgeInsets.only(top: 10, left: 4),
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
                        appBar: state.isLandscapeOrientation ||
                                state.isPlayingVideoMode
                            ? null
                            : AppBar(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                centerTitle: true,
                                leading: state.isPlayingVideoMode
                                    ? SizedBox.shrink()
                                    : null,
                                title: state.isPlayingVideoMode
                                    ? SizedBox.shrink()
                                    : Text(
                                        mediaFiles.length > 1
                                            ? '${mediaFiles.length - _bloc.state.mediaFileIndex}/${mediaFiles.length}'
                                            : '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                actions: [
                                  state.isPlayingVideoMode
                                      ? SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: onDeleteMediaFile,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18.0),
                                              child: Container(
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 24,
                                                  color: Color(0xFFF75555),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                        body: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                color: Colors.black,
                                child: ExtendedImageGesturePageView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final mediaFile = mediaFiles[index];
                                    return mediaFile.contentType ==
                                            CameraContentType.photo
                                        ? PhotoPreviewWidget(
                                            mediaFile: mediaFile,
                                            photoOrientationIsPortrait: state
                                                    .contentOrientationsIsPortraitList[
                                                index],
                                          )
                                        : VideoPreviewWidget(
                                            mediaFile: mediaFile,
                                            videoOrientationIsPortrait: state
                                                    .contentOrientationsIsPortraitList[
                                                index],
                                            key: ObjectKey(
                                                mediaFile.stepFile!.path),
                                          );
                                  },
                                  itemCount: mediaFiles.length,
                                  onPageChanged: (int index) async {
                                    onCommentSaved(_textController.text, _bloc);
                                    _bloc.add(ChangedContentEvent(index));
                                    focusNode.unfocus();
                                    _textController.text =
                                        mediaFiles[index].stepFile?.comment ??
                                            '';
                                  },
                                  controller: _pageController,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),
                            state.isPlayingVideoMode ||
                                    (comment != null && comment.isNotEmpty)
                                ? SizedBox.shrink()
                                : Column(
                                    children: [
                                      Expanded(child: SizedBox()),
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.black.withOpacity(0.35),
                                        ),
                                        padding: EdgeInsets.all(3),
                                        child: TextField(
                                          controller: _textController,
                                          focusNode: focusNode,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          minLines: 1,
                                          maxLines: 3,
                                          onSubmitted: (text) =>
                                              onCommentSaved(text, _bloc),
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.left,
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                12, 8, 6, 8),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                onCommentSaved(
                                                  _textController.text,
                                                  _bloc,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Icon(
                                                  Icons.send,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            hintText: S
                                                .of(context)
                                                .previewPhotoScreenEnterComment,
                                            hintStyle: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                fontSize: 17),
                                            disabledBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      )
                    : Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        backgroundColor: Colors.black,
                        body: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onCommentSaved(String newComment, [MediaPreviewPageBloc? bloc]) {
    mediaFiles[_bloc.state.mediaFileIndex] =
        mediaFiles[_bloc.state.mediaFileIndex].copyWith(
      stepFile: mediaFiles[_bloc.state.mediaFileIndex]
          .stepFile
          ?.copyWith(comment: newComment),
    );
    widget.onChangedComment(_bloc.state.mediaFileIndex, newComment);
    bloc?.add(UpdateUiEvent());
  }

  void onDeleteMediaFile() {
    final index = _bloc.state.mediaFileIndex;
    widget.onDelete(
      mediaFiles[index],
    );
    if (!widget.isOpenedFromCamera && mediaFiles[index].file == null) {
      mediaFiles.removeAt(index);
    }
    if (mediaFiles.length == 0) {
      Navigator.pop(context);
      return;
    }
    _bloc.add(ChangedContentEvent(
      index == mediaFiles.length ? index - 1 : index,
    ));
    _textController.text =
        mediaFiles[index == mediaFiles.length ? index - 1 : index]
                .stepFile
                ?.comment ??
            '';
  }

  void _showCommentBottomSheet(BuildContext context, String comment) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (modalContext) => Column(
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
                  _textController.text = '';
                  Navigator.of(modalContext).pop();
                  onCommentSaved('', context.read<MediaPreviewPageBloc>());
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
                  comment,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 34),
        ],
      ),
    );
  }
}