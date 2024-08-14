// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:easy_sbp/models/bank.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'easy_sbp_platform_interface.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart';

// const paymentUrl =
//     'https://qr.nspk.ru/AS100001ORTF4GAF80KPJ53K186D9A3G?type=01&bank=100000000111&sum=100&cur=RUB&crc=0C8A';
// const paymentUrl =
//     'https://qr.nspk.ru/AS100001ORTF4GAF80KPJ53K186D9A3G?type=01&bank=100000000111&sum=100&cur=RUB';

// const paymentUrl =
//     'https://qr.nspk.ru/AS1A007S6L54D2GE8BIP92DSJCED7O6M?type=01&bank=100000000007&sum=100&cur=RUB&crc=037F';

const paymentUrl =
    'https://qr.nspk.ru/BD100051V7823SEF85KAEVEM7THF62OC?type=02';

// BD100051V7823SEF85KAEVEM7THF62OC
// https://qr.nspk.ru/BD100051V7823SEF85KAEVEM7THF62OC?type=02&bank=100000000004&sum=82000&cur=RUB&crc=3A95

class EasySbp {
  // static const MethodChannel _channel = MethodChannel('sbp_pay');

  // static bool _wasInitialized = false;

  /// Флаг доступности [SbpPay] на данном устройстве.
  ///
  /// Доступен только после успешного [init], иначе ошибка.
  static bool get isAvailable => _isAvailable;
  static late bool _isAvailable;

  /// Инициализация плагина SbpPay.
  ///
  /// Возвращает false, если сервис не поддерживается устройством.
  // static Future<bool> init() async {
  //   if (!_wasInitialized) {
  //     _isAvailable = await _channel
  //         .invokeMethod<bool?>('init')
  //         .then((value) => value ?? false);

  //     _wasInitialized = true;
  //     return _isAvailable;
  //   }

  //   return _isAvailable;
  // }

  /// Вызов нативного окна SbpPay выбора банков.
  // static Future<void> showPaymentModal(String link) {
  //   return _channel.invokeMethod('showPaymentModal', link);
  // }

  Future<String?> getPlatformVersion() {
    return EasySbpPlatform.instance.getPlatformVersion();
  }

  /// Returns list of banks from nspk api.
  Future<List<Bank>> getBankList() async {
    try {
      /// Fetch banks list.
      final response = await http.get(
        Uri.parse('https://qr.nspk.ru/proxyapp/c2bmembers.json'),
      );

      /// Decode response body from Json.
      final decodedMap = jsonDecode(response.body) as Map<String, dynamic>;

      /// Decode dictionary with banks from Json.
      final bankList = decodedMap['dictionary'] as List;

      /// Create empty bank list to fill it with parsed banks data later.
      final mappedList = <Bank>[];

      /// Parse bank data.
      for (final item in bankList) {
        final bank = Bank.fromJson(item);
        mappedList.add(bank);
      }

      // print('____BANK_LIST____: ${mappedList}');

      return mappedList;
    } catch (e) {
      print('____ERROR____: ${e}');

      /// Return empty bank list if something went wrong.
      return <Bank>[];
    }
  }

  /// Try to open bank app.
  ///
  /// If user doesn't have installed bank app, then try to open it in the browser.
  ///
  /// If neither the bank app nor the payment page in the browser can be opened, it is a good practice to provide the user with information about this.
  Future<void> openBank(
    BuildContext context,
    bool mounted, {
    required Bank bank,
  }) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final fixedPaymentUrl = paymentUrl.replaceAll(RegExp('https://'), '');
    final link = '${bank.schema}://$fixedPaymentUrl';

    // print('LINK: $link');

    bool isBankAppWasLaunched = false;

    try {
      isBankAppWasLaunched = await launchUrlString(
        link,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } catch (e) {
      print('ERROR openBank: $e');
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
          'Most likely, the user does not have the application of this bank installed');

      // Fallback option: Open a web URL if available
      if (bank.webClientUrl.isNotEmpty) {
        try {
          await launchUrlString(
            bank.webClientUrl,
            mode: LaunchMode.externalApplication,
          );
        } catch (e) {
          print('ERROR opening webClientUrl: $e');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Указанный банк не был найден')),
        );
      }
    }
  }
}
