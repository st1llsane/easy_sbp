// ignore_for_file: avoid_print

import 'package:easy_sbp/easy_sbp.dart';
import 'package:easy_sbp/models/bank.dart';
import 'package:flutter/material.dart';

class BankItem extends StatefulWidget {
  final Bank bank;

  const BankItem({
    super.key,
    required this.bank,
  });

  @override
  State<BankItem> createState() => _BankItemState();
}

class _BankItemState extends State<BankItem> {
  final esbp = EasySbp();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.bank.bankName);
        esbp.openBank(
          context,
          mounted,
          bank: widget.bank,
        );
      },
      splashColor: Colors.grey.shade200,
      overlayColor: WidgetStateProperty.all<Color>(Colors.grey.shade100),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    child: Image.network(
                      widget.bank.logoURL,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.bank.bankName,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
