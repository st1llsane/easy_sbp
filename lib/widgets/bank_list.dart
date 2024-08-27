part of 'sbp_modal.dart';

class _BankList extends StatelessWidget {
  final List<Bank> bankList;
  final String paymentUrl;
  final VoidCallback handleGetBankList;
  final bool isLoading;
  final bool isEmpty;
  final ESbpModalTheme theme;
  final Function()? onInitiatePayment;

  const _BankList({
    required this.bankList,
    required this.paymentUrl,
    required this.handleGetBankList,
    required this.isLoading,
    required this.isEmpty,
    this.theme = const ESbpModalTheme(),
    this.onInitiatePayment,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // Show loading indicator if isLoading == true
        if (isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey.shade500,
            ),
          );
        }

        // Show error message if isLoading == false and isEmpty == true
        if (!isLoading && isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Возникла ошибка при попытке получить список банков',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => handleGetBankList(),
                    label: const Text(
                      'Повторить попытку',
                      style: TextStyle(fontSize: 20),
                    ),
                    icon: const Icon(
                      Icons.replay_outlined,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      elevation: const WidgetStatePropertyAll(0),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Render bank list if isLoading == false and isEmpty == false
        return ListView.separated(
          itemCount: bankList.length,
          separatorBuilder: (_, __) => Divider(
            color: Colors.grey.shade200,
            height: 1,
          ),
          itemBuilder: (context, index) {
            final bank = bankList[index];
            return _BankItem(
              bank: bank,
              paymentUrl: paymentUrl,
              theme: theme,
              onInitiatePayment: onInitiatePayment,
            );
          },
        );
      },
    );
  }
}
