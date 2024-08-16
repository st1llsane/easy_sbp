import 'package:easy_sbp/esbp.dart';
import 'package:easy_sbp/models/bank.dart';
import 'package:easy_sbp/shared/enums.dart';
import 'package:easy_sbp/widgets/info_modal.dart';
import 'package:flutter/material.dart';

class BankItem extends StatefulWidget {
  final Bank bank;
  final String paymentUrl;

  const BankItem({
    super.key,
    required this.paymentUrl,
    required this.bank,
  });

  @override
  State<BankItem> createState() => _BankItemState();
}

class _BankItemState extends State<BankItem> {
  final esbp = ESbp();

  Future<OpenBankResult> handleOpenBank() async {
    return await esbp.openBank(
      context,
      mounted,
      bank: widget.bank,
      paymentUrl: widget.paymentUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(widget.bank.bankName.trim().toLowerCase());
        return;
        OpenBankResult openBankResult = await handleOpenBank();

        if (openBankResult == OpenBankResult.failure && context.mounted) {
          infoModal(
            context,
            title: 'Произошла ошибка',
            description:
                'К сожалению, на данный момент, оплата через этот банк недоступна',
          );
        }
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      widget.bank.logoURL,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      semanticLabel: '${widget.bank.bankName} logo',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.bank.bankName,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
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
