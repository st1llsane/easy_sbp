// ignore_for_file: avoid_print

import 'package:easy_sbp/easy_sbp.dart';
import 'package:easy_sbp/models/bank.dart';
import 'package:easy_sbp/widgets/bank_list.dart';
import 'package:flutter/material.dart';

class SbpModal extends StatefulWidget {
  /// Includes [Title], [SearchTextField] and scrollable [BankList].
  const SbpModal({super.key});

  @override
  State<SbpModal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SbpModal> {
  final esbp = EasySbp();
  late TextEditingController searchController;
  List<Bank> bankList = [];
  bool isLoading = true;
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();

    handleGetBankList();
    searchController = TextEditingController();
  }

  void handleGetBankList() async {
    bankList = await esbp.getBankList();

    if (mounted) {
      setState(() {
        isLoading = false;

        if (bankList.isNotEmpty) {
          isEmpty = false;
        }
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
              right: 15,
              bottom: 15,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        print('Back');
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 18,
                      ),
                      constraints: BoxConstraints.loose(
                        const Size.fromRadius(18),
                      ),
                    ),
                    const Text(
                      'Оплата через СБП',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),

                // Don't need to show search bar if bank list is empty
                if (!isLoading && !isEmpty) ...[
                  const SizedBox(height: 10),
                  SearchBar(
                    onChanged: (value) => print(value),
                    onTapOutside: (_) => (),
                    hintText: 'Введите название банка',
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
                      const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                    ),
                    constraints: const BoxConstraints(minHeight: 40),
                    shadowColor: null,
                    elevation: const WidgetStatePropertyAll(0),
                    backgroundColor:
                        WidgetStateProperty.all(Colors.grey.shade200),
                    hintStyle: WidgetStatePropertyAll(TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    )),
                    textStyle: const WidgetStatePropertyAll(TextStyle(
                      fontSize: 16,
                    )),
                    keyboardType: TextInputType.text,
                    controller: searchController,
                  ),
                ],
              ],
            ),
          ),

          Divider(
            color: Colors.grey.shade200,
            height: 1,
          ),

          // List of banks
          Expanded(
            child: BankList(
              bankList: bankList,
              handleGetBankList: handleGetBankList,
              isLoading: isLoading,
              isEmpty: isEmpty,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showSbpModal(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    sheetAnimationStyle: AnimationStyle(
      duration: Durations.medium2,
      reverseDuration: Durations.short4,
    ),
    builder: (_) => const SbpModal(),
  );
}
