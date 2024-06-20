import 'package:crypto_app/layers/data/datasources/coin_datasource.dart';
import 'package:crypto_app/layers/data/dtos/coin_dto.dart';
import 'package:crypto_app/layers/domain/services/icon_service.dart';
import 'package:dio/dio.dart';

class CoinRemoteDatasourceImpl implements CoinDatasource{
  final String url = "https://economia.awesomeapi.com.br";
  final IconService iconService;
  final Dio dio;

  CoinRemoteDatasourceImpl(this.iconService, this.dio);
  
  @override
  Future getAllCoins() async {
    var response = await dio.get(
          "$url/json/last/USD-BRL,ETH-BRL,EUR-BRL,BTC-BRL,JPY-BRL,LTC-BRL,GBP-BRL,AUD-BRL,CHF-BRL,CAD-BRL,ARS-BRL,CLP-BRL,UYU-BRL,INR-BRL,ILS-BRL,TRY-BRL,SEK-BRL,DKK-BRL,NOK-BRL,ZAR-BRL,PLN-BRL,RUB-BRL");

    // var response = await dio.get(
    //     "$url/json/last/ETH-BRL,BTC-BRL,LTC-BRL,DOGE-BRL");

    var responseData = response.data as Map<String, dynamic>;

    List<CoinDto> coinList = responseData.entries
        .map((entry) {
          final coin = CoinDto.fromJson(entry.value);
          coin.iconPath = iconService.getIconPath(coin.code!);
          return coin;
        })
        .toList();

    print("CoinList: $coinList");
    
    return coinList;
  }

}