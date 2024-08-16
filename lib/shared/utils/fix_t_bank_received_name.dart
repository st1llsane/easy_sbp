import 'package:easy_sbp/models/bank.dart';

List<Bank> fixTBankReceivedName(List<Bank> banks) {
  final List<Bank> fixedBankList = [];

  for (final bank in banks) {
    String bankName = bank.bankName;

    if (bankName.trim().toLowerCase() == 't-банк') {
      bankName = 'Т-Банк';
    }

    fixedBankList.add(Bank(
      logoURL: bank.logoURL,
      schema: bank.schema,
      bankName: bankName,
      webClientUrl: bank.webClientUrl,
    ));
  }

  return fixedBankList;
}
