// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// Future<void> openBank(BuildContext context,
//     {required String schema, required String paymentUrl}) async {
//   ScaffoldMessenger.of(context).removeCurrentSnackBar();

//   final fixedPaymentUrl = paymentUrl.replaceAll(RegExp('https://'), '');
//   final link = '$schema://$fixedPaymentUrl';

//   try {
//     final wasLaunched = await launchUrlString(
//       link,
//       mode: LaunchMode.externalApplication,
//     );
//     if (!mounted) return;
//     _statesMapNotifier.value = {
//       'wasRestarted': false,
//       'wasTransited': wasLaunched,
//     };
//   } on Object {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Такого банка нет')),
//     );
//   }
// }