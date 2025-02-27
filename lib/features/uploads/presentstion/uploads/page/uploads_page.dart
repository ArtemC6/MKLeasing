import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leasing_company/api/ReviewService.dart';
import 'package:leasing_company/core/drift/drift.dart' as drift;
import 'package:leasing_company/core/presentation/widgets/on_center_widget.dart';
import 'package:leasing_company/features/uploads/presentstion/uploads/bloc/uploads_bloc.dart';
import 'package:leasing_company/features/uploads/presentstion/uploads/bloc/uploads_state.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';

import '../../../../tasks/domain/enums/task_status.dart';

class UploadsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UploadsPageState();
}

class UploadsPageState extends State<UploadsPage> with WidgetsBindingObserver {
  final toastService = getIt<ToastService>();

  String? companyUuid;
  int? articleRemoteId;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      articleRemoteId = (ModalRoute.of(context)?.settings.arguments
          as Map)['articleRemoteId'] as int;
      companyUuid = (ModalRoute.of(context)?.settings.arguments
          as Map)['companyUuid'] as String;
    }

    return BlocBuilder<UploadsBloc, UploadsState>(
      builder: (context, state) {
        Widget? body;
        if (state is UploadsLoadInProgressState)
          body = OnCenterWidget(widget: CircularProgressIndicator());
        else if (state is UploadsReadyState) {
          var groups = state.reviewGroupsStream;
          if (articleRemoteId != null) {
            groups = groups
                .where((g) =>
                    g.review.remoteArticleId == articleRemoteId &&
                    g.review.companyUuid == companyUuid)
                .toList();
          }
          if (groups.length == 0) {
            body = OnCenterWidget(
                message: S.of(context).uploadsScreenUploadsScreenIsEmpty);
          } else {
            body = ListView(
              padding: EdgeInsets.all(5),
              children: groups
                  .map((reviewGroup) => reviewUploadsWidget(reviewGroup))
                  .toList(),
            );
          }
        } else if (state is UploadsFailureState)
          body = Text(S.of(context).unexpectedException);
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Text(S.of(context).uploadsScreenTitle),
          ),
          body: body,
        );
      },
    );
  }

  Widget reviewUploadsWidget(ReviewGroupUploads reviewGroup) {
    String reviewCreated = DateFormat('dd.MM.yyyy HH:mm')
        .format(reviewGroup.review.onDeviceStartedAt);

    String title = 'Отчет «${reviewGroup.template.name}» от $reviewCreated';
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23),
      child: ListTile(
        contentPadding: EdgeInsets.only(top: 15),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.w800),
            textAlign: TextAlign.start),
        subtitle: Column(
            children: reviewGroup.uploads
                .map((u) => uploadWidget(reviewGroup, u))
                .toList()),
      ),
    );
  }

  Widget uploadWidget(ReviewGroupUploads reviewGroup, drift.Upload upload) {
    Map entityActions = {
      EntityAction.REVIEW_STORE.toString():
          S.of(context).uploadsScreenEntiyActionReviewStoreTitle,
      EntityAction.REVIEW_INTERRUPT.toString():
          S.of(context).uploadsScreenEntiyActionReviewInterruptTitle,
      EntityAction.REVIEW_FINISH.toString():
          S.of(context).uploadsScreenEntiyActionReviewFinishTitle,
      EntityAction.STEP_FILE_UPLOAD.toString():
          S.of(context).uploadsScreenEntiyActionStepFileUploadTitle,
      EntityAction.LOCATION_UPLOAD.toString():
          S.of(context).uploadsScreenEntiyActionLocationUploadTitle,
      EntityAction.ATTACH_COMMENTS.toString(): S.of(context).uploadsScreenEntiyActionAttachCommentsTitle,
      EntityAction.ATTACH_VIOLATIONS.toString(): S.of(context).uploadsScreenEntiyActionAttachViolationsTitle,
      EntityAction.ATTACH_DELETING_FILES.toString(): S.of(context).uploadsScreenEntiyActionDeletingFilesTitle,
    };

    Map stateNew = {
      EntityAction.REVIEW_STORE.toString(): Icons.edit,
      EntityAction.REVIEW_INTERRUPT.toString(): Icons.close,
      EntityAction.REVIEW_FINISH.toString(): Icons.done,
      EntityAction.STEP_FILE_UPLOAD.toString(): Icons.file_present_outlined,
      EntityAction.LOCATION_UPLOAD.toString(): Icons.location_on_outlined,
      EntityAction.ATTACH_COMMENTS.toString(): Icons.comment_outlined,
      EntityAction.ATTACH_VIOLATIONS.toString(): Icons.dangerous_outlined,
      EntityAction.ATTACH_DELETING_FILES.toString(): Icons.delete_forever_outlined,
    };

    String title = (entityActions[upload.entityAction] ?? 'Undefined');
    if (upload.entityType == EntityType.STEP_FILE.toString()) {
      var file = reviewGroup.files.firstWhere((f) => f.uuid == upload.entityId);
      title += ' от ${DateFormat('dd.MM.yyyy HH:mm').format(file.createdAt)}';
    }
    String subtitle =
        (upload.progress < 0 ? 0 : upload.progress).toString() + ' %';

    Map extractId = {
      EntityType.REVIEW.toString(): () => 'review-${upload.reviewUuid}',
      EntityType.STEP_FILE.toString(): () =>
          'review-${upload.reviewUuid}, file-${upload.entityId}',
      EntityType.LOCATION.toString(): () =>
          'review-${upload.reviewUuid}, location-${upload.entityId}',
    };

    String id = extractId[upload.entityType]() ?? 'undefined entity type?';

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          visualDensity: VisualDensity(horizontal: -4, vertical: 0),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                stateNew[upload.entityAction],
                color: TaskStatus.values[upload.status].statusColor,
              ),
            ],
          ),
          onLongPress: () async {
            await Clipboard.setData(ClipboardData(text: id));
            toastService.showSuccessToast(
                context, S.of(context).uploadsScreenIdHasBeenCopiedMessage(id));
          },
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // subtitle: upload.status != TaskStatus.completed.value
          //     ? Text(subtitle)
          //     : null
        ),
      ),
    );
  }
}
