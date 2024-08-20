import 'package:easy_sbp/shared/theme/esbp_theme_abstract.dart';
import 'package:flutter/material.dart';

class ESbpButtonTheme extends ESbpThemeAbstract {
  final bool isShowIcon;
  final double gap;
  final double height;
  final EdgeInsets padding;

  const ESbpButtonTheme({
    super.bgColor = const Color(0xFF08113E),
    super.fgColor = const Color(0xFFFFFFFF),
    this.isShowIcon = true,
    this.gap = 8,
    this.height = 44,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 16,
    ),
  });
}

class ESbpModalTheme extends ESbpThemeAbstract {
  final Color headerBgColor;
  final Color searchBarBgColor;
  final Color searchBarHintColor;
  final bool isShowBottomDivider;
  final Color dividerColor;

  const ESbpModalTheme({
    // Modal header
    this.headerBgColor = const Color(0xFFFFFFFF),
    this.searchBarBgColor = const Color(0xFFEEEEEE),
    this.searchBarHintColor = const Color(0xFFBDBDBD),
    this.isShowBottomDivider = true,
    this.dividerColor = const Color(0xFFEEEEEE),
    // Modal body
    super.bgColor = const Color(0xFFFFFFFF),
    super.fgColor = const Color(0xFF212121),
  });
}
