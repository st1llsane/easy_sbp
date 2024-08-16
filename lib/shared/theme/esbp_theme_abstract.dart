import 'package:flutter/material.dart';

abstract class ESbpThemeAbstract {
  final Color bgColor;
  final Color fgColor;

  const ESbpThemeAbstract({
    required this.bgColor,
    required this.fgColor,
  });
}
