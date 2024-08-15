import 'package:easy_sbp/shared/theme/my_theme_extension.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const MyThemeExtension(
        primaryColor: Colors.amber,
      )
    ],
  );

  static final darkTheme = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const MyThemeExtension(
        primaryColor: Colors.black26,
      )
    ],
  );
}
