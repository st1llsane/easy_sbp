// import 'package:easy_sbp/widgets/bank_view.dart';
import 'package:easy_sbp/widgets/sbp_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_sbp/shared/theme/my_theme.dart';
// import 'package:flutter/scheduler.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:easy_sbp/easy_sbp.dart';

void main() {
  // timeDilation = 5;
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
  bool isLightTheme = true;

  void toggleTheme() {
    setState(() => isLightTheme = !isLightTheme);
  }

  // String _platformVersion = 'Unknown';
  // final _easySbpPlugin = EasySbp();

  // @override
  // void initState() {
  //   super.initState();

  //   initPlatformState();
  // }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;

  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion = await _easySbpPlugin.getPlatformVersion() ??
  //         'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });

  //   print('PLATFORM VERSION: $_platformVersion');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: toggleTheme,
                child: const Text('Change Theme'),
              ),
              const SizedBox(width: 15),
              // BankView(),
              const SbpButton()
            ],
          ),
        ),
      ),
    );
  }
}
