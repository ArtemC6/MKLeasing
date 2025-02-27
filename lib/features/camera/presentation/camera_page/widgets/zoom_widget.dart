import 'package:flutter/material.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/bloc/camera_bloc.dart';

class ZoomWidget extends StatefulWidget {
  final Function(double) onChangeZoomLevel;
  final double maxZoomLevel;
  final CameraState cameraState;

  const ZoomWidget({
    Key? key,
    required this.onChangeZoomLevel,
    required this.maxZoomLevel,
    required this.cameraState,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ZoomWidgetState();
}

class _ZoomWidgetState extends State<ZoomWidget> {
  List<double> zoomLevels = [5, 3, 2, 1];
  CameraState? previousCameraState;
  late int zoomIndex = zoomLevels.length - 1;

  @override
  void initState() {
    super.initState();
    _getListAvailableZoom();
  }

  void _getListAvailableZoom() {
    if (zoomLevels.first > widget.maxZoomLevel) {
      zoomLevels.removeAt(0);
      _getListAvailableZoom();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (previousCameraState?.isCameraReady !=
        widget.cameraState.isCameraReady) {
      zoomIndex = zoomLevels.length - 1;
    }
    previousCameraState = widget.cameraState;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: zoomLevels
              .map(
                (zoomLevel) => GestureDetector(
                  onTap: () {
                    widget.onChangeZoomLevel(zoomLevel);
                    setState(() {
                      zoomIndex = zoomLevels.indexOf(zoomLevel);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: zoomLevel == zoomLevels[zoomIndex]
                          ? Color(0xFFC9C9C9).withOpacity(0.5)
                          : Colors.black.withOpacity(0.75),
                    ),
                    child: AnimatedRotation(
                      turns: widget.cameraState.orientationAngle,
                      duration: Duration(milliseconds: 400),
                      child: Text(
                        '${zoomLevel.toInt()}X',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
