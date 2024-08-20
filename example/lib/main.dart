import 'package:easy_sbp/esbp.dart';
import 'package:easy_sbp/widgets/sbp_button.dart';
import 'package:flutter/material.dart';

// Test payment url.
const String paymentUrl =
    'https://qr.nspk.ru/BD10005L4ASST1199F79JPLJRVKKP6Q4?type=01&bank=100000000123&sum=1000&cur=RUB&crc=F314';

// For ios: banks schemes that you would like to see in your app.
// You should provide the same schemes to LSApplicationQueriesSchemes in info.plist.
const List<String> bankSchemesToLoad = [
  // sberbank
  'bank100000000111',
  // t-bank
  'bank100000000004',
  // vtb
  'bank110000000005',
  // alfa-bank
  'bank100000000008',
  // raiffeisen
  'bank100000000007',
  // openbank
  'bank100000000015',
  // gazprombank
  'bank100000000001',
  // psbank - promsvyazbank
  'bank100000000010',
  // sovcom
  'bank100000000013',
  // rosbank
  'bank100000000012',
  // rshb - rosselhozbank
  'bank100000000020',
  // ...
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TestSbp(),
      ),
    );
  }
}

class TestSbp extends StatelessWidget {
  final esbp = ESbp();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              // Use ESbpButton.
              child: ESbpButton(
                onPressed: () => handleOnPressed(context),
                bankSchemesToLoad: bankSchemesToLoad,
                isHandleLifecycle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleOnPressed(BuildContext context) {
    esbp.showSbpModal(
      context,
      paymentUrl,
      bankSchemesToLoad: bankSchemesToLoad,
    );
  }
}
