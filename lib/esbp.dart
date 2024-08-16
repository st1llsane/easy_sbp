// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:easy_sbp/models/bank.dart';
import 'package:easy_sbp/shared/enums.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'esbp_platform_interface.dart';
import 'package:http/http.dart' as http;

class ESbp {
  Future<String?> getPlatformVersion() {
    return ESbpPlatform.instance.getPlatformVersion();
  }

  /// Returns list of banks from nspk api.
  Future<List<Bank>> getBankList() async {
    try {
      // Fetch banks list.
      final response = await http.get(
        Uri.parse('https://qr.nspk.ru/proxyapp/c2bmembers.json'),
      );

      // Decode response body from Json.
      final decodedMap = jsonDecode(response.body) as Map<String, dynamic>;

      // Decode dictionary with banks from Json.
      final bankList = decodedMap['dictionary'] as List;

      // Create empty bank list to fill it with parsed banks data later.
      final mappedList = <Bank>[];

      // Parse bank data.
      for (final item in bankList) {
        final bank = Bank.fromJson(item);
        mappedList.add(bank);
      }

      // print('____BANK_LIST____: ${mappedList}');

      return mappedList;
    } catch (e) {
      print('____ERROR____: $e');

      /// Return empty bank list if something went wrong.
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

    final link =
        Uri.parse(paymentUrl.replaceAll(RegExp('https://'), bank.schema));
    // final link = Uri.parse('${bank.schema}://$fixedPaymentUrl');

    print('LINK: $link');

    bool isBankAppWasLaunched = false;

    try {
      isBankAppWasLaunched = await launchUrl(
        link,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print('ERROR openBank: $e');

      // return OpenBankResult.failure;
    }

    // // Ensure the state is still mounted before interacting with notifier
    // if (!mounted) return;
    // _statesMapNotifier.value = {
    //   'wasRestarted': false,
    //   'wasTransited': wasLaunched,
    // };

    // print('WAS LAUNCHED: $isBankAppWasLaunched');

    if (!isBankAppWasLaunched) {
      print('Could not launch app with link: $link.\n'
          "Most likely, user doesn't have this bank app installed");

      // Fallback option: Open bank in app web view
      if (paymentUrl.isNotEmpty) {
        try {
          print('Try to launch in app browser: $paymentUrl');

          await launchUrl(
            // bank.webClientUrl,
            Uri.parse(paymentUrl),
            mode: LaunchMode.inAppWebView,
          );
        } catch (e) {
          print('ERROR opening webClientUrl: $e');

          return OpenBankResult.failure;
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Указанный банк не был найден')),
          );
        }

        return OpenBankResult.failure;
      }
    }

    return OpenBankResult.success;
  }
}
