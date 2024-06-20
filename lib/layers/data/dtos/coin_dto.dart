import 'package:crypto_app/layers/domain/entities/coin_entity.dart';

class CoinDto extends CoinEntity {
  CoinDto({
  required String? code,
  required String? codein,
  required String? name,
  required double? high,
  required double? low,
  required double? varBid,
  required double? pctChange,
  required double? bid,
  required double? ask,
  required String? timestamp,
  required String? createDate,
  required String? iconPath,
  }) : super(
          code: code,
          ask: ask,
          codein: codein,
          name: name,
          high: high,
          low: low,
          varBid: varBid,
          pctChange: pctChange,
          bid: bid,
          timestamp: timestamp,
          createDate: createDate,
          iconPath: iconPath,
        );

  factory CoinDto.fromJson(Map<String, dynamic> json) {
    return CoinDto(
      code: json['code'],
      codein: json['codein'],
      name: json['name'],
      high: double.tryParse(json['high']) ?? 0.0,
      low: double.tryParse(json['low']) ?? 0.0,
      varBid: double.tryParse(json['varBid']) ?? 0.0,
      pctChange: double.tryParse(json['pctChange']) ?? 0.0,
      bid: double.tryParse(json['bid']) ?? 0.0,
      ask: double.tryParse(json['ask']) ?? 0.0,
      timestamp: json['timestamp'],
      createDate: json['create_date'],
      iconPath: '', // Default value if not present in JSON
    );
  }
}
