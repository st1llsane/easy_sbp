import 'package:flutter/material.dart';

class MyThemeExtension extends ThemeExtension<MyThemeExtension> {
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? backgroundColor;

  const MyThemeExtension({
    this.primaryColor,
    this.secondaryColor,
    this.backgroundColor,
  });

  @override
  MyThemeExtension copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
  }) {
    return MyThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MyThemeExtension lerp(MyThemeExtension? other, double t) {
    if (other is! MyThemeExtension) {
      return this;
    }

    return MyThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }

  @override
  String toString() =>
      'MyThemeExtension(primaryColor: $primaryColor, secondaryColor: $secondaryColor, backgroundColor: $backgroundColor)';

  // // Static method to access the theme extension
  // static MyThemeExtension of(BuildContext context) {
  //   return Theme.of(context).extension<MyThemeExtension>()!;
  // }
}

// class MyTheme extends ThemeData {
//   static const _defaultTheme = ThemeData();

//   const MyTheme({
//     required super.extension,
//     required super.brightness,
//     super.colorScheme,
//     super.textTheme,
//     super.iconTheme,
//     super.appBarTheme,
//     super.bottomNavigationBarTheme,
//     super.floatingActionButtonTheme,
//     super.buttonTheme,
//     super.platform,
//     super.useMaterial3,
//   }) : super(
//           brightness: brightness,
//           colorScheme: colorScheme ?? _defaultTheme.colorScheme,
//           textTheme: textTheme ?? _defaultTheme.textTheme,
//           iconTheme: iconTheme ?? _defaultTheme.iconTheme,
//           appBarTheme: appBarTheme ?? _defaultTheme.appBarTheme,
//           bottomNavigationBarTheme: bottomNavigationBarTheme ??
//               _defaultTheme.bottomNavigationBarTheme,
//           floatingActionButtonTheme:
//               floatingActionButtonTheme ?? _defaultTheme.floatingActionButtonTheme,
//           buttonTheme: buttonTheme ?? _defaultTheme.buttonTheme,
//           platform: platform ?? _defaultTheme.platform,
//           useMaterial3: useMaterial3 ?? _defaultTheme.useMaterial3,
//         );

//   // Метод для создания темы с вашими расширениями
//   factory MyTheme.from(
//     BuildContext context, {
//     Color? primaryColor,
//     Color? secondaryColor,
//     Color? backgroundColor,
//   }) {
//     return MyTheme(
//       extension: MyThemeExtension(
//         primaryColor: primaryColor,
//         secondaryColor: secondaryColor,
//         backgroundColor: backgroundColor,
//       ),
//       brightness: Theme.of(context).brightness,
//     );
//   }
// }
