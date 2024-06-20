import 'package:crypto_app/layers/core/failure.dart';
import 'package:crypto_app/layers/domain/entities/coin_entity.dart';

abstract class GetAllCoinsState{}

class GetAllCoinsLoadingState extends GetAllCoinsState{}

class GetAllCoinsSucessfulState extends GetAllCoinsState{
  final List<CoinEntity> coinsList;

  GetAllCoinsSucessfulState({required this.coinsList});
}

class GetAllCoinsErrorState extends GetAllCoinsState{
  final Failure failure;

  GetAllCoinsErrorState({required this.failure});
}