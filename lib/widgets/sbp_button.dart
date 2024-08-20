import 'package:easy_sbp/esbp.dart';
import 'package:easy_sbp/shared/theme/esbp_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ESbpButton extends StatefulWidget {
  final String paymentUrl;
  final List<String>? bankSchemesToLoad;
  // final VoidCallback onComplete;
  final ESbpButtonTheme sbpButtonTheme;
  final ESbpModalTheme sbpModalTheme;
  final bool isHandleLifecycle;

  const ESbpButton({
    super.key,
    required this.paymentUrl,
    this.bankSchemesToLoad,
    // required this.onComplete,
    this.sbpButtonTheme = const ESbpButtonTheme(),
    this.sbpModalTheme = const ESbpModalTheme(),
    this.isHandleLifecycle = false,
  });

  @override
  State<ESbpButton> createState() => _ESbpButtonState();
}

class _ESbpButtonState extends State<ESbpButton> {
  final esbp = ESbp();
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
        isAppResumed = true;
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
    return ElevatedButton(
      onPressed: () {
        if (!isAppResumed) {
          return;
        }

        esbp.showSbpModal(
          context,
          widget.sbpModalTheme,
          widget.paymentUrl,
          widget.bankSchemesToLoad,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isAppResumed
            ? widget.sbpButtonTheme.bgColor
            : widget.sbpButtonTheme.bgColor.withOpacity(.6),
        foregroundColor: widget.sbpButtonTheme.fgColor,
        surfaceTintColor: widget.sbpButtonTheme.bgColor,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: widget.sbpButtonTheme.padding,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: isAppResumed
            ? [
                if (widget.sbpButtonTheme.isShowIcon) ...[
                  Opacity(
                    opacity: isAppResumed ? 1 : .6,
                    child: Image.asset(
                      'assets/sbp_logo.png',
                      package: 'easy_sbp',
                      width: 28,
                      height: 28,
                    ),
                  ),
                  SizedBox(width: widget.sbpButtonTheme.gap),
                ],
                Text(
                  "СБП",
                  style: TextStyle(
                    color: isAppResumed
                        ? widget.sbpButtonTheme.fgColor
                        : widget.sbpButtonTheme.fgColor.withOpacity(.6),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                )
              ]
            : [
                const CircularProgressIndicator(),
              ],
      ),
    );
  }
}
