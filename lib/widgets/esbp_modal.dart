// ignore_for_file: avoid_print

import 'package:easy_sbp/easy_sbp.dart';
import 'package:easy_sbp/models/bank.dart';
import 'package:easy_sbp/shared/theme/esbp_theme.dart';
import 'package:easy_sbp/widgets/bank_list.dart';
import 'package:flutter/material.dart';

class ESbpModal extends StatefulWidget {
  final ESbpModalTheme theme;

  /// Includes [Title], [SearchTextField] and scrollable [BankList].
  const ESbpModal({
    super.key,
    this.theme = const ESbpModalTheme(),
  });

  @override
  State<ESbpModal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ESbpModal> {
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
            color: widget.theme.headerBgColor,
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
                    Text(
                      'Оплата через СБП',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: widget.theme.fgColor,
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
                    elevation: WidgetStatePropertyAll(
                      widget.theme.searchBarElevation,
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      widget.theme.searchBarBgColor,
                    ),
                    hintStyle: WidgetStatePropertyAll(
                      TextStyle(
                        color: widget.theme.searchBarHintColor,
                        fontSize: 16,
                      ),
                    ),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(
                        color: widget.theme.fgColor,
                        fontSize: 16,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    controller: searchController,
                  ),
                ],
              ],
            ),
          ),

          if (widget.theme.isShowBottomDivider) ...[
            Divider(
              height: 1,
              color: widget.theme.dividerColor,
            ),
          ],

          // List of banks
          Expanded(
            child: Container(
              color: widget.theme.bgColor,
              child: BankList(
                bankList: bankList,
                handleGetBankList: handleGetBankList,
                isLoading: isLoading,
                isEmpty: isEmpty,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showSbpModal(BuildContext context, ESbpModalTheme theme) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    sheetAnimationStyle: AnimationStyle(
      duration: Durations.medium2,
      reverseDuration: Durations.short4,
    ),
    builder: (_) => ESbpModal(theme: theme),
  );
}
