import 'package:easy_sbp_example/api/get_bank_list.dart';
import 'package:easy_sbp_example/models/bank.dart';
import 'package:flutter/material.dart';

class BankList extends StatefulWidget {
  const BankList({super.key});

  @override
  State<BankList> createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: ValueListenableBuilder(
      //     valueListenable: _statesMapNotifier,
      //     builder: (_, statesMap, __) {
      //       final wasRestarted = statesMap['wasRestarted'] ?? false;
      //       final wasTransited = statesMap['wasTransited'] ?? false;
      //       return Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             'Свернуто и открыто: $wasRestarted',
      //             style: const TextStyle(fontSize: 18),
      //           ),
      //           Text(
      //             'Переход в банк: $wasTransited',
      //             style: const TextStyle(fontSize: 18),
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: FutureBuilder<List<Bank>>(
          future: getBankList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade500,
                ),
              );
            }

            late final data = snapshot.data ?? [];

            if (data.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Возникла ошибка при попытке получить список банков',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: getBankList,
                      child: Text(
                        'Повторить попытку',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              );
            }

            return ListView.separated(
              itemCount: data.length,
              separatorBuilder: (_, __) => Divider(
                color: Colors.grey.shade300,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final bank = data[index];

                return InkWell(
                  // onTap: () => _openBank(context, schema: bank.schema),
                  onTap: () => (),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Image.network(
                                bank.logoURL,
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  bank.bankName,
                                  style: const TextStyle(fontSize: 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
