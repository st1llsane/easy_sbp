import 'package:easy_sbp_example/widgets/bank_view_layout.dart';
import 'package:flutter/material.dart';

class BankView extends StatelessWidget {
  const BankView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('EASY SBP'),
      //   backgroundColor: Colors.grey.shade200,
      //   surfaceTintColor: Colors.grey.shade200,
      // ),
      body: Center(
        child: BankViewLayout(),
      ),
    );
  }
}
