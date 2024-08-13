import 'package:easy_sbp_example/models/bank.dart';
import 'package:flutter/material.dart';

class BankList extends StatelessWidget {
  final List<Bank> bankList;
  final VoidCallback handleGetBankList;
  final bool isLoading;
  final bool isEmpty;

  const BankList({
    super.key,
    required this.bankList,
    required this.handleGetBankList,
    required this.isLoading,
    required this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // Show loading indicator if isLoading
        if (isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey.shade500,
            ),
          );
        }

        // Show error message if is not isLoading and isEmpty
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
                    onPressed: handleGetBankList,
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

        // Show bank list if not isLoading and not isEmpty
        return ListView.separated(
          itemCount: bankList.length,
          separatorBuilder: (_, __) => Divider(
            color: Colors.grey.shade200,
            height: 1,
          ),
          itemBuilder: (context, index) {
            final bank = bankList[index];

            return InkWell(
              onTap: () => print(bank.bankName),
              splashColor: Colors.grey.shade200,
              overlayColor: WidgetStateProperty.all<Color>(Colors.red.shade600),
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
                            bank.logoURL,
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              bank.bankName,
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
          },
        );
      },
    );
  }
}
