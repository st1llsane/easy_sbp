import 'package:easy_sbp/shared/theme/esbp_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ESbpButton extends StatefulWidget {
  final Function() onPressed;
  final List<String>? bankSchemesToLoad;
  final bool isHandleLifecycle;
  final bool isLoading;
  final bool isDisabled;
  final ESbpButtonTheme sbpButtonTheme;
  final ESbpModalTheme sbpModalTheme;

  const ESbpButton({
    super.key,
    required this.onPressed,
    this.bankSchemesToLoad,
    this.isHandleLifecycle = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.sbpButtonTheme = const ESbpButtonTheme(),
    this.sbpModalTheme = const ESbpModalTheme(),
  });

  @override
  State<ESbpButton> createState() => _ESbpButtonState();
}

class _ESbpButtonState extends State<ESbpButton> {
  late final AppLifecycleListener _listener;
  late AppLifecycleState? _state;
  bool isAppResumed = true;

  @override
  void initState() {
    super.initState();

    if (widget.isHandleLifecycle) {
      _state = SchedulerBinding.instance.lifecycleState;
      _listener = AppLifecycleListener(
        onStateChange: _handleStateChange,
      );
    }
  }

  void _handleStateChange(AppLifecycleState state) {
    setState(() {
      _state = state;

      if (_state == null || _state == AppLifecycleState.resumed) {
        Future.delayed(
          Duration(
            milliseconds: widget.sbpButtonTheme.disableButtonOnResumeDuration,
          ),
          () {
            setState(() {
              isAppResumed = true;
            });
          },
        );
      } else {
        isAppResumed = false;
      }
    });
  }

  @override
  void dispose() {
    if (widget.isHandleLifecycle) {
      _listener.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.sbpButtonTheme.height,
      child: ElevatedButton(
        onPressed: () {
          if (!isAppResumed || widget.isLoading || widget.isDisabled) {
            return;
          }

          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isAppResumed && !widget.isLoading && !widget.isDisabled
                  ? widget.sbpButtonTheme.bgColor
                  : widget.sbpButtonTheme.bgColor.withOpacity(.6),
          foregroundColor: widget.sbpButtonTheme.fgColor,
          surfaceTintColor: widget.sbpButtonTheme.bgColor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              widget.sbpButtonTheme.borderRadius,
            ),
          ),
          padding: widget.sbpButtonTheme.padding,
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isAppResumed && !widget.isLoading
              ? [
                  if (widget.sbpButtonTheme.isShowIcon) ...[
                    Opacity(
                      opacity: isAppResumed && !widget.isDisabled ? 1 : .6,
                      child: Image.asset(
                        'assets/sbp_logo.png',
                        package: 'easy_sbp',
                        width: widget.sbpButtonTheme.iconSize.width,
                        height: widget.sbpButtonTheme.iconSize.height,
                      ),
                    ),
                    SizedBox(width: widget.sbpButtonTheme.gap),
                  ],
                  Text(
                    "СБП",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isAppResumed && !widget.isDisabled
                          ? widget.sbpButtonTheme.fgColor
                          : widget.sbpButtonTheme.fgColor.withOpacity(.6),
                      fontSize: widget.sbpButtonTheme.fontSize,
                      fontWeight: widget.sbpButtonTheme.fontWeight,
                    ),
                  )
                ]
              : [
                  Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: defaultTargetPlatform == TargetPlatform.iOS
                          ? CupertinoActivityIndicator(
                              color: widget.sbpButtonTheme.fgColor,
                            )
                          : CircularProgressIndicator(
                              color: widget.sbpButtonTheme.fgColor,
                              strokeWidth: 3,
                              semanticsLabel: 'Circular progress indicator',
                            ),
                    ),
                  )
                ],
        ),
      ),
    );
  }
}
