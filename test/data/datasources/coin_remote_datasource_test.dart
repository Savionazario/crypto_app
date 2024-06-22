import 'dart:convert';

import 'package:crypto_app/layers/core/constants/currency_icons.dart';
import 'package:crypto_app/layers/data/datasources/coin_datasource.dart';
import 'package:crypto_app/layers/data/datasources/remote/coin_remote_datasource_impl.dart';
import 'package:crypto_app/layers/data/dtos/coin_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockIconService mockIconService;
  late CoinDatasource coinRemoteDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    mockIconService = MockIconService();
    coinRemoteDataSourceImpl =
        CoinRemoteDatasourceImpl(mockIconService, mockDio);
  });

  group(
    "get coins list",
    () {
      const String url = "https://economia.awesomeapi.com.br";
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: json.decode(readJson("helpers/dummy_data/dummy_coin_list_response.json")),
        statusCode: 200,
      );

      test(
        "Should return a list of coin dto when the response is 200",
        () async {
          // arrange
          when(
            mockDio.get("$url/json/last/USD-BRL,ETH-BRL,EUR-BRL,BTC-BRL,JPY-BRL,LTC-BRL,GBP-BRL,AUD-BRL,CHF-BRL,CAD-BRL,ARS-BRL,CLP-BRL,UYU-BRL,INR-BRL,ILS-BRL,TRY-BRL,SEK-BRL,DKK-BRL,NOK-BRL,ZAR-BRL,PLN-BRL,RUB-BRL"),
          ).thenAnswer(
            (_) async => response,
          );

          when(mockIconService.getIconPath(any)).thenReturn(currencyIcons["USD"]!);

          // act
          final result = await coinRemoteDataSourceImpl.getAllCoins();

          // assert
          expect(result, isA<List<CoinDto>>());
        },
      );
    },
  );
}
