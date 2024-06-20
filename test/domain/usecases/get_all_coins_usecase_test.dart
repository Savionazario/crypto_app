import 'package:crypto_app/layers/domain/entities/coin_entity.dart';
import 'package:crypto_app/layers/domain/usecases/get_all_coins_usecase.dart/get_all_coins_usecase.dart';
import 'package:crypto_app/layers/domain/usecases/get_all_coins_usecase.dart/get_all_coins_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllCoinsUsecase getAllCoinsUsecase;
  late MockCoinRepository mockCoinRepository; // Essa Classe é gerada pelo build_runner

  // Método que é executado antes de qualquer test
  setUp(() {
    mockCoinRepository = MockCoinRepository();
    getAllCoinsUsecase = GetAllCoinsUsecaseImpl(mockCoinRepository);
  });

  final List<CoinEntity> testCoinList = [
    CoinEntity(
      ask: 2.0,
      bid: 2.0,
      code: "BTC",
      codein: "BRL",
      createDate: "213161561",
      high: 2000.0,
      low: 1000.0,
      iconPath: "",
      name: "Bitcoin",
      pctChange: 2.0,
      timestamp: "1353353",
      varBid: 5000.0,
    ),
  ];
  test(
    "Deve obter a lista de todas as moedas do repositório",
    () async {
      // arrange
      when(mockCoinRepository.getAllCoins()).thenAnswer((_) async => Right(testCoinList));

      // act
      final result = await getAllCoinsUsecase.call();

      // assert
      expect(result, Right(testCoinList));
    },
  );
}
