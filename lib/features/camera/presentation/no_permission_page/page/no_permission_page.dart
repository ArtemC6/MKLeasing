import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/toast_service.dart';
import 'package:permission_handler/permission_handler.dart';

class NoPermissionPage extends StatefulWidget {
  final List<Permission> permissions;
  final Future<List<Permission>> Function(List<Permission>) checkPermissions;

  const NoPermissionPage({
    Key? key,
    required this.permissions,
    required this.checkPermissions,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoPermissionPageState();
}

class _NoPermissionPageState extends State<NoPermissionPage> {
  final ToastService toastService = getIt();
  List<Permission> requiredPermissions = [];
  final listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    requiredPermissions = widget.permissions;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
          ..pop()
          ..pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: Text(
                  S.of(context).goToSettingsAndGiveAccessTo,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 100,
                child: AnimatedList(
                    key: listKey,
                    physics: NeverScrollableScrollPhysics(),
                    initialItemCount: requiredPermissions.length,
                    itemBuilder: (context, index, animation) {
                      return listItem(requiredPermissions[index]);
                    }),
              ),
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.transparent, width: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xffE9F0FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      )),
                  child: Wrap(
                    children: [
                      Text(
                        S.of(context).makeMediaPageOpenAppSettings,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xff246BFD),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () => openAppSettings(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.transparent, width: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 28),
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff4B86FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).accessGranted,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    final updatedPermissions =
                        await widget.checkPermissions(widget.permissions);
                    if (updatedPermissions.isEmpty) {
                      Navigator.of(context).pop();
                    } else {
                      final grantedPermissions = requiredPermissions
                          .where((element) =>
                              !updatedPermissions.contains(element))
                          .toList();
                      grantedPermissions.forEach((element) {
                        listKey.currentState?.removeItem(
                          requiredPermissions.indexOf(element),
                          (context, animation) => SlideTransition(
                            position: animation.drive(Tween<Offset>(
                              begin: const Offset(1, 0.0),
                              end: Offset.zero,
                            )),
                            child: listItem(element),
                          ),
                          duration: Duration(seconds: 1),
                        );
                      });
                      requiredPermissions = updatedPermissions;
                      toastService.showFailureToast(
                        context,
                        S.of(context).notAllRequiredPermitsHaveBeenIssued,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(Permission permission) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width / 3.3),
          SvgPicture.asset(
            permissionIconAsset(permission),
            color: Colors.black,
            width: 24,
            height: 24,
          ),
          SizedBox(width: 16),
          Text(
            permissionWithLocalization(context, permission),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  String permissionWithLocalization(
      BuildContext context, Permission permission) {
    if (permission == Permission.camera) return S.of(context).camera;
    if (permission == Permission.microphone) return S.of(context).microphone;
    if (permission == Permission.location) return S.of(context).location;
    if (permission == Permission.notification) return S.of(context).notifications;
    return 'Добавьте локализацию для permission'; //For developers
  }

  String permissionIconAsset(Permission permission) {
    if (permission == Permission.camera) return 'assets/icons/photo.svg';
    if (permission == Permission.microphone)
      return 'assets/icons/microphone.svg';
    if (permission == Permission.location) return 'assets/icons/location.svg';
    if (permission == Permission.notification) return 'assets/icons/notification.svg';
    return ''; //For developers
  }
}
