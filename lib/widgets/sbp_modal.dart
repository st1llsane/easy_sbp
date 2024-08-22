import 'package:easy_sbp/esbp.dart';
import 'package:easy_sbp/models/bank.dart';
import 'package:easy_sbp/shared/theme/esbp_theme.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_sbp/shared/types/enums.dart';

part 'bank_list.dart';
part 'bank_item.dart';
part 'info_modal.dart';

class ESbpModal extends StatefulWidget {
  final ESbpModalTheme theme;
  final String paymentUrl;
  final List<String>? bankSchemesToLoad;

  /// Includes [Title], [TextField] and scrollable [BankList].
  const ESbpModal({
    super.key,
    required this.paymentUrl,
    this.bankSchemesToLoad,
    this.theme = const ESbpModalTheme(),
  });

  @override
  State<ESbpModal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ESbpModal> {
  final esbp = ESbp();
  late FocusNode textFieldNode;
  late TextEditingController textFieldController;
  List<Bank> bankList = [];
  bool isLoading = true;
  bool isEmpty = true;
  List<Bank> searchResult = [];

  @override
  void initState() {
    super.initState();

    handleGetBankList();
    textFieldNode = FocusNode();
    textFieldController = TextEditingController();
  }

  void handleGetBankList() async {
    bankList = await esbp.getBankList(widget.bankSchemesToLoad);

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
    textFieldNode.dispose();
    textFieldController.dispose();
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
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 18,
                        color: widget.theme.fgColor,
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

                // Don't need to show text field if bank list is empty
                if (!isLoading && !isEmpty) ...[
                  const SizedBox(height: 10),
                  TextField(
                    focusNode: textFieldNode,
                    controller: textFieldController,
                    onChanged: searchBank,
                    onTapOutside: (_) => textFieldNode.unfocus(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Введите название банка',
                      hintStyle: TextStyle(
                        color: widget.theme.searchBarHintColor,
                        fontSize: 16,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      filled: true,
                      fillColor: widget.theme.searchBarBgColor,
                    ),
                    style: TextStyle(
                      color: widget.theme.fgColor,
                      fontSize: 16,
                      height: 1,
                    ),
                    cursorColor: widget.theme.fgColor,
                    keyboardType: TextInputType.text,
                    enableSuggestions: false,
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
              child: _BankList(
                bankList: searchResult.isEmpty ? bankList : searchResult,
                paymentUrl: widget.paymentUrl,
                handleGetBankList: handleGetBankList,
                isLoading: isLoading,
                isEmpty: isEmpty,
                theme: widget.theme,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
