import 'package:flutter/material.dart';
import 'package:leasing_company/features/camera/presentation/no_permission_page/page/no_permission_page.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<PermissionStatus> askPermissionOnce(Permission permission) async {
    return permission.request();
  }

  Future<bool> checkPermissions(BuildContext context,
      {required List<Permission> permissions}) async {
    List<Permission> notGrantedPermissionsList = [];
    for (Permission permission in permissions) {
      final isHavePermission =
          await permission.request() == PermissionStatus.granted;
      if (!isHavePermission) {
        notGrantedPermissionsList.add(permission);
      }
    }
    if (notGrantedPermissionsList.isEmpty) {
      return true;
    }
    List<Permission> grantedPermissions = [];
    for (Permission permission in notGrantedPermissionsList) {
      final isPermissionGranted = await _askPermission(permission);
      if (isPermissionGranted) {
        grantedPermissions.add(permission);
      }
    }
    grantedPermissions.forEach((element) {
      notGrantedPermissionsList.remove(element);
    });
    if (notGrantedPermissionsList.isEmpty) {
      return true;
    }
    return await _showNoPermissionPage(notGrantedPermissionsList, context);
  }

  Future<bool> _showNoPermissionPage(
      List<Permission> permissions, BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoPermissionPage(
          permissions: permissions,
          checkPermissions: _checkPermissions,
        ),
      ),
    );
    List<Permission> notGrantedPermission = [];
    for (Permission permission in permissions) {
      if (await permission.status != PermissionStatus.granted) {
        notGrantedPermission.add(permission);
      }
    }
    return notGrantedPermission.isEmpty;
  }

  Future<bool> _askPermission(Permission permission) async {
    PermissionStatus permissionStatus;
    do {
      permissionStatus = await permission.request();
      await Future.delayed(Duration(seconds: 1));
    } while (permissionStatus != PermissionStatus.granted &&
        permissionStatus != PermissionStatus.permanentlyDenied);
    return permissionStatus == PermissionStatus.granted;
  }

  Future<List<Permission>> _checkPermissions(List<Permission> permissions) async {
    List<Permission> notGrantedPermissionsList = [];
    for (Permission permission in permissions) {
      final isHavePermission =
          await permission.request() == PermissionStatus.granted;
      if (!isHavePermission) {
        notGrantedPermissionsList.add(permission);
      }
    }
    return notGrantedPermissionsList;
  }
}
