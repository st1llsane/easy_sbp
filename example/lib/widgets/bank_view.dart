import 'package:easy_sbp_example/widgets/bank_list.dart';
import 'package:flutter/material.dart';

class BankView extends StatelessWidget {
  const BankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy SBP'),
        backgroundColor: Colors.grey.shade300,
      ),
      body: const Center(
        child: BankList(),
      ),
    );
  }
}
