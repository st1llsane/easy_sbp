import 'dart:convert';

import 'package:easy_sbp_example/models/bank.dart';
import 'package:http/http.dart' as http;

/// Returns list of banks from https://qr.nspk.ru/proxyapp/c2bmembers.json
Future<List<Bank>> getBankList() async {
  try {
    /// Fetch banks list
    final response = await http.get(
      Uri.parse('https://qr.nspk.ru/proxyapp/c2bmembers.json'),
    );

    /// Decode response body from Json
    final decodedMap = jsonDecode(response.body) as Map<String, dynamic>;

    /// Decode dictionary with banks from Json
    final bankList = decodedMap['dictionary'] as List;

    // print('BANK LIST: ${bankList}');

    /// Create empty bank list to fill it with parsed banks data later
    final mappedList = <Bank>[];

    /// Parse bank data
    for (final item in bankList) {
      final bank = Bank.fromJson(item);
      mappedList.add(bank);
    }

    return mappedList;

    /// Return empty bank list if something went wrong
  } on Exception {
    return <Bank>[];
  }
}
