import 'package:easy_sbp/widgets/sbp_button.dart';
import 'package:flutter/material.dart';

class BankView extends StatelessWidget {
  const BankView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SbpButton(),
            )
          ],
        ),
      ),
    );
  }
}
