import 'package:easy_sbp/shared/theme/esbp_theme.dart';
import 'package:easy_sbp/widgets/esbp_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ESbpButton(
                    sbpButtonTheme: ESbpButtonTheme(),
                    sbpModalTheme: ESbpModalTheme(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
