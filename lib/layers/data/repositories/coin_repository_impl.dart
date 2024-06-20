import 'package:crypto_app/layers/core/failure.dart';
import 'package:crypto_app/layers/data/datasources/coin_datasource.dart';
import 'package:crypto_app/layers/domain/entities/coin_entity.dart';
import 'package:crypto_app/layers/domain/repositories/coin_repository.dart';
import 'package:dartz/dartz.dart';

class CoinRepositoryImpl implements CoinRepository {
  CoinDatasource _coinDatasource;

  CoinRepositoryImpl(this._coinDatasource);

  @override
  Future<Either<Failure, List<CoinEntity>>> getAllCoins() async {
    try {
      var result = await _coinDatasource.getAllCoins();

      return Right(result);
    } catch (e) {
      return Left(GenericFailure(failureMessage: "Ops, algo deu errado."));
    }
  }
  
  @override
  Future<Either<Failure, List<CoinEntity>>> getCoinMonthHistory() {
    // TODO: implement getCoinMonthHistory
    throw UnimplementedError();
  }
}
