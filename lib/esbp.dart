// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:easy_sbp/models/bank.dart';
import 'package:easy_sbp/shared/types/enums.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'esbp_platform_interface.dart';
import 'package:http/http.dart' as http;

class ESbp {
  Future<String?> getPlatformVersion() {
    return ESbpPlatform.instance.getPlatformVersion();
  }

  /// Return list of banks from nspk api.
  ///
  /// If bankSchemesToLoad has been provided, then render only banks with appropriate schemes.
  /// !!!Dont forget to add the same schemes in your info.plist LSApplicationQueriesSchemes array!!!.
  Future<List<Bank>> getBankList(List<String>? bankSchemesToLoad) async {
    try {
      // Fetch bank list.
      final response = await http.get(
        Uri.parse('https://qr.nspk.ru/proxyapp/c2bmembers.json'),
      );

      // Decode response body from Json.
      final decodedMap = jsonDecode(response.body) as Map<String, dynamic>;

      // Decode dictionary with banks from Json.
      final decodedBankList = decodedMap['dictionary'] as List;

      // Create empty bank list to fill it with filterd bank data later.
      final List<Bank> bankList = [];

      // Filter bank data.
      final List listForMapping = bankSchemesToLoad ?? decodedBankList;
      for (int i = 0; i < listForMapping.length; i++) {
        final bank = Bank.fromJson(decodedBankList[i]);
        String bankName = bank.bankName;

        if (bank.schema.isEmpty ||
            bank.bankName.isEmpty ||
            bank.logoURL.isEmpty) {
          continue;
        }

        // If bankSchemesToLoad has been provided, then add only banks with appropriate schemes.
        if (bankSchemesToLoad != null && bankSchemesToLoad[i] != bank.schema) {
          continue;
        }

        // Fix T-Bank received name, because in the api we get T-Bank with English "T" word.
        if (bankName.trim().toLowerCase() == 't-банк') {
          bankName = 'Т-Банк';
        }

        bankList.add(Bank(
          logoURL: bank.logoURL,
          schema: bank.schema,
          bankName: bankName,
        ));
      }

      return bankList;
    } catch (e) {
      print('ERROR when getBankList: $e');

      // Return empty bank list if something went wrong.
      return <Bank>[];
    }
  }

  /// Try to open bank app.
  ///
  /// If user doesn't have installed bank app, then try to open payment page in the browser.
  ///
  /// If neither the bank app nor the payment page in the browser can be opened, it is a good practice to provide the user with information about this.
  Future<OpenBankResult> openBank(
    BuildContext context,
    bool mounted, {
    required Bank bank,
    required String paymentUrl,
  }) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final fixedPaymentUrl = paymentUrl.replaceAll(RegExp('https://'), '');
    final link = Uri.parse('${bank.schema}://$fixedPaymentUrl');

    print('LINK: $link');

    bool isBankAppWasLaunched = false;

    try {
      isBankAppWasLaunched = await launchUrl(
        link,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } catch (e) {
      print('ERROR when openBank: $e');
    }

    // print('WAS LAUNCHED: $isBankAppWasLaunched');

    if (!isBankAppWasLaunched) {
      print('Could not launch app with link: $link.\n'
          "Most likely, user doesn't have this bank app installed");

      // Fallback option: Open bank in app browser
      try {
        print('Try to launch in app browser: $paymentUrl');

        isBankAppWasLaunched = await launchUrl(
          Uri.parse(paymentUrl),
          mode: LaunchMode.inAppBrowserView,
        );

        if (isBankAppWasLaunched) {
          return OpenBankResult.success;
        }
      } catch (e) {
        print('ERROR opening bank in app browser: $e');

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Произошла ошибка. Попробуйте другой банк.')),
          );
        }
      }

      return OpenBankResult.failure;
    }

    return OpenBankResult.success;
  }
}
