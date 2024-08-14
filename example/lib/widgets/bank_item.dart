import 'package:easy_sbp_example/models/bank.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

// const paymentUrl =
//     'https://qr.nspk.ru/AS100001ORTF4GAF80KPJ53K186D9A3G?type=01&bank=100000000111&sum=100&cur=RUB&crc=0C8A';
// const paymentUrl =
//     'https://qr.nspk.ru/AS100001ORTF4GAF80KPJ53K186D9A3G?type=01&bank=100000000111&sum=100&cur=RUB';
const paymentUrl =
    'https://qr.nspk.ru/AS1A007S6L54D2GE8BIP92DSJCED7O6M?type=01&bank=100000000007&sum=100&cur=RUB&crc=037F';

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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.bank.bankName);
        openBank(
          context,
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
                  Image.network(
                    widget.bank.logoURL,
                    height: 40,
                    width: 40,
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

  Future<void> openBank(
    BuildContext context, {
    required Bank bank,
  }) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final fixedPaymentUrl = paymentUrl.replaceAll(RegExp('https://'), '');
    final link = '${bank.schema}://$fixedPaymentUrl';

    print('LINK: $link');

    bool isBankAppWasLaunched = false;

    try {
      isBankAppWasLaunched = await launchUrlString(
        link,
        mode: LaunchMode.externalNonBrowserApplication,
      );

      print('WAS LAUNCHED: $isBankAppWasLaunched');
    } catch (e) {
      print('ERROR openBank: $e');
    }

    // Ensure the state is still mounted before interacting with the context
    if (!mounted) return;

    if (!isBankAppWasLaunched) {
      print('Could not launch $link');

      // Fallback option: Open a web URL if available
      if (bank.webClientUrl.isNotEmpty) {
        try {
          await launchUrlString(
            bank.webClientUrl,
            mode: LaunchMode.externalApplication,
          );
        } catch (e) {
          print('ERROR opening webClientUrl: $e');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Указанный банк не был найден')),
        );
      }
    }
  }
}
