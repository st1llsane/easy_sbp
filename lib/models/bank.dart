import 'dart:convert';

class Bank {
  final String bankName;
  final String logoURL;
  final String schema;
  final String? webClientUrl;

  const Bank({
    required this.bankName,
    required this.logoURL,
    required this.schema,
    this.webClientUrl,
  });

  /// Parse received data from Json
  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      bankName: utf8.decode(json['bankName'].codeUnits) as String? ?? '',
      logoURL: json['logoURL'] as String? ?? '',
      schema: json['schema'] as String? ?? '',
      webClientUrl: json['webClientUrl'] as String? ?? '',
    );
  }
}
