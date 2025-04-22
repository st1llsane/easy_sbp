// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'dart:convert';

import 'package:easy_sbp/models/bank.dart';
import 'package:easy_sbp/shared/theme/esbp_theme.dart';
import 'package:easy_sbp/shared/types/enums.dart';
import 'package:easy_sbp/widgets/sbp_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

const ESbpModalTheme defaultEsbpTheme = ESbpModalTheme();

abstract class SBP {
  /// Simple premade modal with Title, Search bar and List of banks.
  static Future<void> openSbpModal(
    BuildContext context,
    String paymentUrl, {
    List<String>? bankSchemesToLoad,
    ESbpModalTheme? theme,
    double modalHeightFactor = 1,
    Function()? onInitiatePayment,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      sheetAnimationStyle: AnimationStyle(
        duration: Durations.medium2,
        reverseDuration: Durations.short4,
      ),
      builder: (_) => LayoutBuilder(builder: (context, constraints) {
        double modalHeight = constraints.maxHeight * modalHeightFactor;

        return SBPModal(
          paymentUrl: paymentUrl,
          bankSchemesToLoad: bankSchemesToLoad,
          modalHeight: modalHeight,
          theme: theme ?? defaultEsbpTheme,
          onInitiatePayment: onInitiatePayment,
        );
      }),
    );
  }

  /// Return list of banks from nspk api.
  ///
  /// If bankSchemesToLoad has been provided, then render only banks with appropriate schemes.
  ///
  /// !!!If current plarform is ios and bankSchemesToLoad was provided, dont forget to add the same schemes in your info.plist LSApplicationQueriesSchemes array!!!.
  static Future<List<Bank>> getBankList(List<String>? bankSchemesToLoad) async {
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

        if (bank.schema.isEmpty || bank.bankName.isEmpty) {
          continue;
        }

        // If bankSchemesToLoad has been provided, then add only banks with appropriate schemes.
        if (bankSchemesToLoad != null && bankSchemesToLoad[i] != bank.schema) {
          continue;
        }

        // Fix T-Bank received name, because in the api we get T-Bank with English "T".
        if (bankName.trim().toLowerCase() == 't-банк') {
          bankName = 'Т-Банк';
        }

        bankList.add(Bank(
          logoURL: bank.logoURL,
          schema: bank.schema,
          bankName: bankName,
        ));
      }

      List<Bank> finalBankList = bankList;

      if (defaultTargetPlatform == TargetPlatform.iOS && bankList.length > 50) {
        finalBankList = bankList.getRange(0, 50).toList();
      }

      return finalBankList;
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
  static Future<OpenBankResult> openBank(
    BuildContext context, {
    required Bank bank,
    required String paymentUrl,
    Function()? onInitiatePayment,
  }) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    late String _paymentUrl;
    late Uri url;
    late bool isBankAppWasLaunched = false;

    // Try to launch bank app
    try {
      if (bank.webClientUrl != null) {
        _paymentUrl = paymentUrl.replaceAll(RegExp('https://qr.nspk.ru'), '');
        url = Uri.parse('${bank.webClientUrl}://$_paymentUrl');

        isBankAppWasLaunched = await launchUrl(
          url,
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        _paymentUrl = paymentUrl.replaceAll(RegExp('https://'), '');
        url = Uri.parse('${bank.schema}://$_paymentUrl');

        isBankAppWasLaunched = await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      print('ERROR when openBank: $e');
    }

    if (!isBankAppWasLaunched) {
      // Fallback option: Open bank in app browser
      try {
        isBankAppWasLaunched = await launchUrl(
          Uri.parse(paymentUrl),
          mode: LaunchMode.inAppBrowserView,
        );

        if (isBankAppWasLaunched) {
          // Call onInitiatePayment func if exist.
          Future.delayed(Duration(milliseconds: 800), () {
            onInitiatePayment?.call();
          });

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
