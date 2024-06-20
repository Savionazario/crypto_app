import 'package:crypto_app/layers/core/failure.dart';
import 'package:crypto_app/layers/domain/entities/coin_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetAllCoinsUsecase{
  Future<Either<Failure, List<CoinEntity>>> call();
}