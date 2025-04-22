part of 'sbp_modal.dart';

class _BankItem extends StatefulWidget {
  const _BankItem({
    required this.paymentUrl,
    required this.bank,
    this.theme = const ESbpModalTheme(),
    this.onInitiatePayment,
  });

  final Bank bank;
  final String paymentUrl;
  final ESbpModalTheme theme;
  final Function()? onInitiatePayment;

  @override
  State<_BankItem> createState() => _BankItemState();
}

class _BankItemState extends State<_BankItem> {
  Future<OpenBankResult> handleOpenBank() async {
    Navigator.pop(context);

    return await SBP.openBank(
      context,
      bank: widget.bank,
      paymentUrl: widget.paymentUrl,
      onInitiatePayment: widget.onInitiatePayment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        OpenBankResult openBankResult = await handleOpenBank();

        if (openBankResult == OpenBankResult.failure && context.mounted) {
          _infoModal(
            context,
            title: 'Произошла ошибка',
            description:
                'На текущий момент, оплата через данный банк недоступна',
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
                    child: CachedNetworkImage(
                      imageUrl: widget.bank.logoURL,
                      width: 40,
                      height: 40,
                      placeholder: (context, url) =>
                          imagePlaceholder(widget.bank),
                      errorWidget: (context, url, error) =>
                          imagePlaceholder(widget.bank),
                      fadeInDuration: Duration(microseconds: 500),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.bank.bankName,
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.theme.fgColor,
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

Widget imagePlaceholder(Bank bank) {
  return Container(
    color: Colors.amber.shade200,
    width: 40,
    height: 40,
    alignment: Alignment.center,
    child: Text(
      bank.bankName.isNotEmpty ? bank.bankName[0].toUpperCase() : '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  );
}
