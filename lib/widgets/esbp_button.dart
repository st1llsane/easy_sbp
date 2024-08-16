import 'package:easy_sbp/shared/theme/esbp_theme.dart';
import 'package:easy_sbp/widgets/esbp_modal.dart';
import 'package:flutter/material.dart';

class ESbpButton extends StatelessWidget {
  final ESbpButtonTheme sbpButtonTheme;
  final ESbpModalTheme sbpModalTheme;

  const ESbpButton({
    super.key,
    this.sbpButtonTheme = const ESbpButtonTheme(),
    this.sbpModalTheme = const ESbpModalTheme(),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showSbpModal(context, sbpModalTheme),
      style: ElevatedButton.styleFrom(
        backgroundColor: sbpButtonTheme.bgColor,
        foregroundColor: sbpButtonTheme.fgColor,
        surfaceTintColor: sbpButtonTheme.bgColor,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: sbpButtonTheme.padding,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (sbpButtonTheme.isShowIcon) ...[
            Image.asset(
              'assets/sbp_logo.png',
              package: 'easy_sbp',
              width: 28,
              height: 28,
            ),
            SizedBox(width: sbpButtonTheme.gap),
          ],
          Text(
            "СБП",
            style: TextStyle(
              color: sbpButtonTheme.fgColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          )
        ],
      ),
    );
  }
}
