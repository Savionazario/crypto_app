import 'dart:convert';

import 'package:crypto_app/layers/data/dtos/coin_dto.dart';
import 'package:crypto_app/layers/domain/entities/coin_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  final CoinDto testCoinDto = CoinDto(
    code: "USD",
    codein: "BRL",
    name: "Dólar Americano/Real Brasileiro",
    high: 5.734,
    low: 5.7279,
    varBid: -0.0054,
    pctChange: -0.09,
    bid: 5.7276,
    ask: 5.7282,
    timestamp: "1618315045",
    createDate: "2021-04-13 08:57:27",
    iconPath: ""
  );

  test(
    "Deve ser uma subclasse de CoinEntity",
    () async {
      // assert
      expect(testCoinDto, isA<CoinEntity>());
    },
  );

  test(
    "Deve retornar um dto válido de um json",
    () async {
      // arrange
      final jsonMap = json.decode(readJson("helpers/dummy_data/dummy_coin_response.json"));

      // act
      final result = CoinDto.fromJson(jsonMap);

      // assert
      expect(result, equals(testCoinDto));
    },
  );
}
