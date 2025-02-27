import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:huawei_location/huawei_location.dart' as HL;
import 'package:leasing_company/generated/l10n.dart';
import 'package:location/location.dart';

abstract class LocationService {
  Future<LocationData> getLocation();
  Stream<LocationData>? getLocationStream();
  Future<PermissionStatus> hasPermission();
  Future<bool> serviceEnabled();
  Future<bool> requestService();
  String getServiceDisabledText(BuildContext context);
  Future changeSettings(CustomLocationAccuracy locationAccuracy);
  void close();
}

class LocationServiceImpl implements LocationService {
  late final LocationService _locationService;

  LocationServiceImpl() {
    initialize();
  }

  Future<void> initialize() async {
    if (Platform.isAndroid) {
      final availability = await GoogleApiAvailability.instance.checkGooglePlayServicesAvailability();
      if (availability == GooglePlayServicesAvailability.success ||
          availability == GooglePlayServicesAvailability.serviceUpdating ||
          availability == GooglePlayServicesAvailability.serviceVersionUpdateRequired) {
        _locationService = _DefaultLocationService();
      } else {
        final hmsAvailabilityCode = await HmsApiAvailability().isHMSAvailable();
        _locationService = hmsAvailabilityCode == 0 ? _LocationServiceForHuaweiHonor() : _DefaultLocationService();
      }
    } else {
      _locationService = _DefaultLocationService();
    }
  }

  @override
  Future<LocationData> getLocation() => _locationService.getLocation();

  @override
  Stream<LocationData>? getLocationStream() => _locationService.getLocationStream();

  @override
  Future<PermissionStatus> hasPermission() => _locationService.hasPermission();

  @override
  Future<bool> serviceEnabled() => _locationService.serviceEnabled();

  @override
  Future<bool> requestService() => _locationService.requestService();

  @override
  String getServiceDisabledText(BuildContext context) => _locationService.getServiceDisabledText(context);

  @override
  void close() => _locationService.close();

  @override
  Future changeSettings(CustomLocationAccuracy locationAccuracy) => _locationService.changeSettings(locationAccuracy);
}

class _DefaultLocationService implements LocationService {
  final _locationService = Location();
  bool _isSettingsInitialized = false;

  @override
  Future<LocationData> getLocation() async {
    final location = await _locationService.getLocation();
    // _locationService.
    return LocationData(
      latitude: location.latitude,
      accuracy: location.accuracy,
      isMock: location.isMock,
      longitude: location.longitude,
      time: location.time != null ? DateTime.fromMillisecondsSinceEpoch(location.time!.toInt()) : null,
    );
  }

  @override
  Stream<LocationData>? getLocationStream() {
    return _locationService.onLocationChanged.map(
      (e) => LocationData(
        latitude: e.latitude,
        accuracy: e.accuracy,
        isMock: e.isMock,
        longitude: e.longitude,
        time: e.time != null ? DateTime.fromMillisecondsSinceEpoch(e.time!.toInt()) : null,
      ),
    );
  }

  @override
  Future<PermissionStatus> hasPermission() => _locationService.hasPermission();

  @override
  Future<bool> serviceEnabled() async {
    final isEnable = await _locationService.serviceEnabled();
    await setSettings(isEnable);
    return isEnable;
  }

  @override
  Future<bool> requestService() async {
    final isEnable = await _locationService.requestService();

    await setSettings(isEnable);
    return isEnable;
  }

  Future<void> setSettings(bool isEnable) async {
    if (isEnable && !_isSettingsInitialized) {
      await _locationService.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 5000,
      );
      _isSettingsInitialized = true;
    }
  }

  @override
  void close() {}

  @override
  String getServiceDisabledText(BuildContext context) => S.of(context).turnOnGPS;

  @override
  Future changeSettings(CustomLocationAccuracy locationAccuracy) async {
    final LocationAccuracy accuracy;
    accuracy = switch (locationAccuracy) {
      CustomLocationAccuracy.high => LocationAccuracy.high,
      CustomLocationAccuracy.medium => LocationAccuracy.balanced,
      CustomLocationAccuracy.low => LocationAccuracy.low,
    };
    await _locationService.changeSettings(
      accuracy: accuracy,
      interval: 5000,
    );
  }
}

class _LocationServiceForHuaweiHonor implements LocationService {
  late final HL.FusedLocationProviderClient _locationService;
  HL.LocationRequest? _locationRequest;
  HL.LocationSettingsRequest? _locationSettingsRequest;
  Timer? _timer;
  bool _isSettingsChanged = false;

  @override
  Future<LocationData> getLocation() async {
    await _locationService.requestLocationUpdates(_locationRequest!);
    final location = await locationService.getLastLocation();
    return LocationData(
      latitude: location.latitude,
      accuracy: location.horizontalAccuracyMeters,
      isMock: false,
      longitude: location.longitude,
      time: location.time != null ? DateTime.fromMillisecondsSinceEpoch(location.time!) : null,
    );
  }

  @override
  Stream<LocationData>? getLocationStream() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        await locationService.requestLocationUpdates(_locationRequest!);
      } catch (e) {}
    });
    return locationService.onLocationData?.map(
      (e) => LocationData(
        latitude: e.latitude,
        accuracy: e.horizontalAccuracyMeters,
        isMock: false,
        longitude: e.longitude,
        time: e.time != null ? DateTime.fromMillisecondsSinceEpoch(e.time!) : null,
      ),
    );
  }

  @override
  Future<PermissionStatus> hasPermission() async {
    final locationService = Location();
    if (!_isSettingsChanged) {
      await HL.HMSLogger.disableLogger();
      _locationService = HL.FusedLocationProviderClient()..setMockMode(false);
      _locationRequest = HL.LocationRequest()..priority = 100;
      _locationSettingsRequest = HL.LocationSettingsRequest(
        needBle: true,
        requests: [_locationRequest],
      );
      _isSettingsChanged = true;
    }
    return locationService.hasPermission();
  }

  var locationService = HL.FusedLocationProviderClient();

  @override
  Future<bool> serviceEnabled() async {
    try {
      await locationService.initFusedLocationService();
      final locationInfo = await locationService.getLocationAvailability();
      return locationInfo.locationStatus == 0;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> requestService() async {
    try {
      await locationService.checkLocationSettings(_locationSettingsRequest!);

      return true;
    } catch (e) {
      return !e.toString().contains('PlatformException(LOCATION_SETTINGS_NOT_AVAILABLE, Unable to get location settings,');
    }
  }

  @override
  void close() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  String getServiceDisabledText(BuildContext context) => S.of(context).turnOnLocationServices;

  @override
  Future changeSettings(CustomLocationAccuracy locationAccuracy) async {
    final priority;
    switch (locationAccuracy) {
      case CustomLocationAccuracy.high:
        priority = 100;
        break;
      case CustomLocationAccuracy.medium:
        priority = 102;
        break;
      case CustomLocationAccuracy.low:
        priority = 104;
    }
    _locationSettingsRequest = HL.LocationSettingsRequest(
      requests: [HL.LocationRequest()..priority = priority],
    );
    try {
      await locationService.checkLocationSettings(_locationSettingsRequest!);
      return true;
    } catch (e) {
      return !e.toString().contains('PlatformException(LOCATION_SETTINGS_NOT_AVAILABLE, Unable to get location settings,');
    }
  }
}

class LocationData {
  final double? longitude;
  final double? latitude;
  final double? accuracy;
  final DateTime? time;
  final bool? isMock;

  LocationData({
    required this.latitude,
    required this.accuracy,
    this.time,
    required this.isMock,
    required this.longitude,
  });
}

enum CustomLocationAccuracy {
  high,
  medium,
  low,
}

extension CustomLocationAccuracyExt on CustomLocationAccuracy {
  CustomLocationAccuracy getNextAccuracyMode() {
    final currentModeIndex = CustomLocationAccuracy.values.indexOf(this);
    return currentModeIndex == CustomLocationAccuracy.values.length - 1
        ? CustomLocationAccuracy.values[currentModeIndex]
        : CustomLocationAccuracy.values[currentModeIndex + 1];
  }

  double getLocatingProgressPercent(CustomLocationAccuracy actualLocationAccuracy, int secondsOnTimer) {
    if (this == actualLocationAccuracy) {
      return secondsOnTimer / 120;
    } else {
      return CustomLocationAccuracy.values.indexOf(actualLocationAccuracy) < CustomLocationAccuracy.values.indexOf(this) ? 0 : 1;
    }
  }

  Color getProgressColor(CustomLocationAccuracy actualLocationAccuracy) {
    return CustomLocationAccuracy.values.indexOf(actualLocationAccuracy) > CustomLocationAccuracy.values.indexOf(this) ? Color(0xFFF75555) : Color(0xFF3699FF);
  }

  String getLocalizedAccuracyMode(BuildContext context) {
    switch (this) {
      case CustomLocationAccuracy.high:
        return S.of(context).accuracyHigh;
      case CustomLocationAccuracy.medium:
        return S.of(context).accuracyMedium;
      case CustomLocationAccuracy.low:
        return S.of(context).accuracyLow;
    }
  }
}
