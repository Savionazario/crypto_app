import 'dart:convert';

import 'package:crypto_app/layers/domain/models/coin_model.dart';
import 'package:crypto_app/layers/domain/repositories/coin_repository.dart';
import 'package:dio/dio.dart';

class CoinRepositoryImpl implements CoinRepository {
  final String url = "https://economia.awesomeapi.com.br";
  final Dio dio;

  CoinRepositoryImpl(this.dio);

  @override
  Future<List<CoinModel>> getAllCoins() async {
    try {
      var response = await dio.get(
          "$url/json/last/USD-BRL,ETH-BRL,EUR-BRL,BTC-BRL,JPY-BRL,LTC-BRL,GBP-BRL,AUD-BRL,CHF-BRL,CAD-BRL,ARS-BRL,CLP-BRL,UYU-BRL,INR-BRL,ILS-BRL,TRY-BRL,SEK-BRL,DKK-BRL,NOK-BRL,ZAR-BRL,PLN-BRL,RUB-BRL");

      var responseData = response.data as Map<String, dynamic>;

      List<CoinModel> coinList = responseData.entries
          .map((entry) => CoinModel.fromJson(entry.value))
          .toList();

      print("CoinList: $coinList");

      return coinList;
    } catch (e) {
      print("Erro em getAllCoins: $e");
      throw Exception();
    }
  }
}
