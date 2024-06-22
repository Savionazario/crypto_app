import 'dart:io';

import 'package:crypto_app/layers/core/failure.dart';
import 'package:crypto_app/layers/data/datasources/coin_datasource.dart';
import 'package:crypto_app/layers/data/dtos/coin_dto.dart';
import 'package:crypto_app/layers/domain/services/icon_service.dart';
import 'package:dio/dio.dart';

class CoinRemoteDatasourceImpl implements CoinDatasource {
  final String url = "https://economia.awesomeapi.com.br";
  final IconService iconService;
  final Dio dio;

  CoinRemoteDatasourceImpl(this.iconService, this.dio);

  @override
  Future<List<CoinDto>> getAllCoins() async {
    try {
      var response = await dio.get(
          "$url/json/last/USD-BRL,ETH-BRL,EUR-BRL,BTC-BRL,JPY-BRL,LTC-BRL,GBP-BRL,AUD-BRL,CHF-BRL,CAD-BRL,ARS-BRL,CLP-BRL,UYU-BRL,INR-BRL,ILS-BRL,TRY-BRL,SEK-BRL,DKK-BRL,NOK-BRL,ZAR-BRL,PLN-BRL,RUB-BRL");

      // var response = await dio.get(
      //     "$url/json/last/ETH-BRL,BTC-BRL,LTC-BRL,DOGE-BRL");

      switch (response.statusCode) {
        case HttpStatus.ok:
          {
            var responseData = response.data as Map<String, dynamic>;

            List<CoinDto> coinList = responseData.entries.map((entry) {
              final coin = CoinDto.fromJson(entry.value);
              coin.iconPath = iconService.getIconPath(coin.code!);
              return coin;
            }).toList();

            return coinList;
          }
        case HttpStatus.internalServerError:
          throw ServerFailure(failureMessage: "Algo deu errado no servidor!");
        default:
          throw GenericFailure(failureMessage: "Algo deu errado!");
      }
    } catch (e) {
      throw GenericFailure(failureMessage: "Algo deu errado!");
    }
  }
}
