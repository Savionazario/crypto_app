import 'package:crypto_app/layers/core/failure.dart';
import 'package:crypto_app/layers/domain/models/coin_model.dart';
import 'package:dartz/dartz.dart';

abstract class CoinRepository{
  Future<Either<Failure, List<CoinModel>>> getAllCoins();
}