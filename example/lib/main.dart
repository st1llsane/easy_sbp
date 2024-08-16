import 'package:easy_sbp/widgets/sbp_button.dart';
import 'package:flutter/material.dart';

// Test payment url
const paymentUrl =
    'https://qr.nspk.ru/BD10005L4ASST1199F79JPLJRVKKP6Q4?type=02&bank=100000000123&sum=67000&cur=RUB&crc=F314';

void main() {
  runApp(const MyApp());
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
            vertical: 10,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ESbpButton(
                    paymentUrl: paymentUrl,
                    // onComplete: () {}
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
