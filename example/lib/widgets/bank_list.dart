import 'package:easy_sbp_example/api/get_bank_list.dart';
import 'package:easy_sbp_example/models/bank.dart';
import 'package:flutter/material.dart';

class BankList extends StatefulWidget {
  const BankList({super.key});

  @override
  State<BankList> createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  late TextEditingController searchController;
  final List<Bank> bankList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  Future<List<Bank>> loadBankList() async {
    final bankList = await getBankList();

    setState(() {
      isLoading = false;
    });

    return bankList;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                    ),
                    // onPressed: () {
                    //   Navigator.of(context).pop();
                    // },
                    onPressed: () => print('Back'),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Оплата через СБП',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            if (!isLoading) ...[
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: SearchBar(
                  onChanged: (value) => print(value),
                  hintText: 'Введите название банка',
                  shadowColor: null,
                  elevation: const WidgetStatePropertyAll(0),
                  hintStyle: const WidgetStatePropertyAll(TextStyle(
                    fontSize: 20,
                  )),
                  textStyle: const WidgetStatePropertyAll(TextStyle(
                    fontSize: 20,
                  )),
                  keyboardType: TextInputType.text,
                  controller: searchController,
                ),
              ),
            ],
            Expanded(
              child: Builder(
                builder: (BuildContext context) {
                  if (isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey.shade500,
                      ),
                    );
                  }
                  if (!isLoading && bankList.isEmpty) {
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
                              onPressed: getBankList,
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

                  return ListView.separated(
                    itemCount: bankList.length,
                    separatorBuilder: (_, __) => Divider(
                      color: Colors.grey.shade300,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final bank = bankList[index];

                      return InkWell(
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
                                        style: const TextStyle(fontSize: 20),
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
              ),
              // child: builder<List<Bank>>(
              //   future: loadBankList(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(
              //         child: CircularProgressIndicator(
              //           color: Colors.grey.shade500,
              //         ),
              //       );
              //     }

              //     late final data = snapshot.data ?? [];

              //     if (data.isEmpty) {
              //       return Padding(
              //         padding: const EdgeInsets.all(20),
              //         child: Center(
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               const Text(
              //                 'Возникла ошибка при попытке получить список банков',
              //                 style: TextStyle(fontSize: 20),
              //                 textAlign: TextAlign.center,
              //               ),
              //               const SizedBox(height: 20),
              //               ElevatedButton.icon(
              //                 onPressed: getBankList,
              //                 label: const Text(
              //                   'Повторить попытку',
              //                   style: TextStyle(fontSize: 20),
              //                 ),
              //                 icon: const Icon(
              //                   Icons.replay_outlined,
              //                 ),
              //                 style: ButtonStyle(
              //                   backgroundColor: WidgetStateProperty.all<Color>(
              //                     Colors.transparent,
              //                   ),
              //                   elevation: const WidgetStatePropertyAll(0),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     }

              //     isLoadingOrEmpty = false;

              //     return ListView.separated(
              //       itemCount: data.length,
              //       separatorBuilder: (_, __) => Divider(
              //         color: Colors.grey.shade300,
              //         height: 1,
              //       ),
              //       itemBuilder: (context, index) {
              //         final bank = data[index];

              //         return InkWell(
              //           onTap: () => (),
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(
              //               horizontal: 18,
              //               vertical: 14,
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Flexible(
              //                   child: Row(
              //                     children: [
              //                       Image.network(
              //                         bank.logoURL,
              //                         height: 50,
              //                         width: 50,
              //                       ),
              //                       const SizedBox(width: 10),
              //                       Flexible(
              //                         child: Text(
              //                           bank.bankName,
              //                           style: const TextStyle(fontSize: 20),
              //                           maxLines: 1,
              //                           overflow: TextOverflow.ellipsis,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 const Icon(
              //                   Icons.arrow_forward_ios_rounded,
              //                   size: 18,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
