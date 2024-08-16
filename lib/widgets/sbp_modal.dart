import 'package:easy_sbp/esbp.dart';
import 'package:easy_sbp/models/bank.dart';
import 'package:easy_sbp/shared/theme/esbp_theme.dart';
import 'package:easy_sbp/widgets/bank_list.dart';
import 'package:flutter/material.dart';

class ESbpModal extends StatefulWidget {
  final ESbpModalTheme theme;
  final String paymentUrl;

  /// Includes [Title], [SearchTextField] and scrollable [BankList].
  const ESbpModal({
    super.key,
    required this.paymentUrl,
    this.theme = const ESbpModalTheme(),
  });

  @override
  State<ESbpModal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ESbpModal> {
  final esbp = ESbp();
  late FocusNode searchFocusNode;
  late TextEditingController searchController;
  List<Bank> bankList = [];
  bool isLoading = true;
  bool isEmpty = true;
  List<Bank> searchResult = [];

  @override
  void initState() {
    super.initState();

    handleGetBankList();
    searchFocusNode = FocusNode();
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

  searchBank(String value) {
    setState(() {
      searchResult = bankList
          .where((bank) => bank.bankName.trim().toLowerCase().contains(value))
          .toList();
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
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
              bottom: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 18,
                      ),
                      constraints: BoxConstraints.loose(
                        const Size.fromRadius(18),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                    Text(
                      'Оплата через СБП',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: widget.theme.fgColor,
                        height: 1,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),

                // Don't need to show search bar if bank list is empty
                if (!isLoading && !isEmpty) ...[
                  const SizedBox(height: 10),
                  SearchBar(
                    focusNode: searchFocusNode,
                    controller: searchController,
                    onChanged: searchBank,
                    onTapOutside: (event) => searchFocusNode.unfocus(),
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
                  ),
                  const SizedBox(height: 5),
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
                bankList: searchResult.isEmpty ? bankList : searchResult,
                paymentUrl: widget.paymentUrl,
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

Future<void> showSbpModal(
  BuildContext context,
  ESbpModalTheme theme,
  String paymentUrl,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    sheetAnimationStyle: AnimationStyle(
      duration: Durations.medium2,
      reverseDuration: Durations.short4,
    ),
    builder: (_) => ESbpModal(
      theme: theme,
      paymentUrl: paymentUrl,
    ),
  );
}
