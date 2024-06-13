import 'package:crypto_app/layers/core/failure.dart';
import 'package:crypto_app/layers/domain/models/coin_model.dart';
import 'package:crypto_app/layers/domain/repositories/coin_repository.dart';
import 'package:crypto_app/layers/domain/services/icon_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CoinRepositoryImpl implements CoinRepository {
  final String url = "https://economia.awesomeapi.com.br";
  final IconService iconService;
  final Dio dio;

  CoinRepositoryImpl(this.dio, this.iconService);

  @override
  Future<Either<Failure, List<CoinModel>>> getAllCoins() async {
    try {
      var response = await dio.get(
          "$url/json/last/USD-BRL,ETH-BRL,EUR-BRL,BTC-BRL,JPY-BRL,LTC-BRL,GBP-BRL,AUD-BRL,CHF-BRL,CAD-BRL,ARS-BRL,CLP-BRL,UYU-BRL,INR-BRL,ILS-BRL,TRY-BRL,SEK-BRL,DKK-BRL,NOK-BRL,ZAR-BRL,PLN-BRL,RUB-BRL");

      // var response = await dio.get(
      //     "$url/json/last/ETH-BRL,BTC-BRL,LTC-BRL,DOGE-BRL");

      var responseData = response.data as Map<String, dynamic>;

      List<CoinModel> coinList = responseData.entries
          .map((entry) {
            final coin = CoinModel.fromJson(entry.value);
            coin.iconPath = iconService.getIconPath(coin.code!);
            return coin;
          })
          .toList();

      print("CoinList: $coinList");

      return Right(coinList);
    } catch (e) {
      return Left(GenericFailure(failureMessage: "Ops, algo deu errado."));
    }
  }
}
