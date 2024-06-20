import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  String? code;
  String? codein;
  String? name;
  double? high;
  double? low;
  double? varBid;
  double? pctChange;
  double? bid;
  double? ask;
  String? timestamp;
  String? createDate;
  String? iconPath;

  CoinEntity({
    this.code,
    this.codein,
    this.name,
    this.high,
    this.low,
    this.varBid,
    this.pctChange,
    this.bid,
    this.ask,
    this.timestamp,
    this.createDate,
    this.iconPath,
  });

  @override
  List<Object?> get props => [
        code,
        codein,
        name,
        high,
        low,
        varBid,
        pctChange,
        bid,
        ask,
        timestamp,
        createDate,
        iconPath,
      ];
}
