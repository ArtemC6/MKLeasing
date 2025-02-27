import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/services/platform_service.dart';

class ErrorPage extends StatefulWidget {
  final PlatformInfo platformInfo;
  final bool hasFilesForExport;
  final String description;
  final String? errorMessage;
  final Function() onTryAgain;

  const ErrorPage({
    Key? key,
    required this.platformInfo,
    required this.hasFilesForExport,
    required this.description,
    this.errorMessage,
    required this.onTryAgain,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  bool isErrorOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Color(0xFF6F9EFF),
                        Color(0xFF246BFD),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    Icons.error,
                    size: 70,
                  ),
                ),
              ),
              Text(
                S.of(context).loadingScreenHasBeenCriticalError1,
                style: TextStyle(
                  color: Color(0xFF246BFD),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 2),
              if (widget.errorMessage != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFF64E60),
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  S.of(context).error +
                                      ' ' +
                                      widget.errorMessage!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: isErrorOpen ? 10 : 1,
                                  style: TextStyle(fontSize: 14),
                                ),
                                if (isErrorOpen) SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            isErrorOpen = !isErrorOpen;
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              isErrorOpen
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              color: Color(0xFF777777),
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (widget.errorMessage != null) SizedBox(height: 22),
              Text(
                S.of(context).errorNoConnectionDescription,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 12),
              Text(
                S.of(context).checkYourInternetConnectionAndTryAgain,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF707070)),
              ),
              SizedBox(height: 24),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                splashColor: Colors.white12,
                highlightColor: Colors.white12,
                onTap: widget.onTryAgain,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Color(0xFF246BFD),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  child: Text(
                    S.of(context).tryAgain,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
