import 'dart:convert';

class Bank {
  final String bankName;
  final String logoURL;
  final String schema;
  final String webClientUrl;

  const Bank({
    required this.bankName,
    required this.logoURL,
    required this.schema,
    required this.webClientUrl,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      bankName: utf8.decode(json['bankName'].codeUnits) as String? ?? '',
      logoURL: json['logoURL'] as String? ?? '',
      schema: json['schema'] as String? ?? '',
      webClientUrl: json['webClientUrl'] as String? ?? '',
    );
  }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Bank &&
  //         runtimeType == other.runtimeType &&
  //         bankName == other.bankName &&
  //         logoURL == other.logoURL &&
  //         schema == other.schema;

  // @override
  // int get hashCode => bankName.hashCode ^ logoURL.hashCode ^ schema.hashCode;
}
