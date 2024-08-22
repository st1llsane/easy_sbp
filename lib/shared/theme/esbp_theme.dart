import 'package:flutter/material.dart';

part 'esbp_theme_abstract.dart';

class ESbpButtonTheme extends _ESbpThemeAbstract {
  final Size iconSize;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isShowIcon;
  final double gap;
  final double height;
  final EdgeInsets padding;
  final double borderRadius;

  /// If isHandleLifecycle == true, you can provide your own time in milliseconds, how long button will be disabled when onResume event happened.
  final int disableButtonOnResumeDuration;

  const ESbpButtonTheme({
    super.bgColor = const Color(0xFF08113E),
    super.fgColor = const Color(0xFFFFFFFF),
    this.iconSize = const Size(24, 24),
    this.fontSize = 18,
    this.fontWeight = FontWeight.w500,
    this.isShowIcon = true,
    this.gap = 8,
    this.height = 44,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 16,
    ),
    this.borderRadius = 4,
    this.disableButtonOnResumeDuration = 500,
  });
}

class ESbpModalTheme extends _ESbpThemeAbstract {
  final Color headerBgColor;
  final Color searchBarBgColor;
  final Color searchBarHintColor;
  final bool isShowBottomDivider;
  final Color dividerColor;

  const ESbpModalTheme({
    super.bgColor = const Color(0xFFFFFFFF),
    super.fgColor = const Color(0xFF212121),
    // Modal header
    this.headerBgColor = const Color(0xFFFFFFFF),
    this.searchBarBgColor = const Color(0xFFEEEEEE),
    this.searchBarHintColor = const Color(0xFFBDBDBD),
    this.isShowBottomDivider = true,
    this.dividerColor = const Color(0xFFEEEEEE),
  });
}
