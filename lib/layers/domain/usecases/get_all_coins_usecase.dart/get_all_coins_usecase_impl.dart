import 'package:crypto_app/layers/core/failure.dart';
import 'package:crypto_app/layers/domain/models/coin_model.dart';
import 'package:crypto_app/layers/domain/repositories/coin_repository.dart';
import 'package:crypto_app/layers/domain/usecases/get_all_coins_usecase.dart/get_all_coins_usecase.dart';
import 'package:dartz/dartz.dart';

class GetAllCoinsUsecaseImpl implements GetAllCoinsUsecase{
  final CoinRepository _coinRepository;

  GetAllCoinsUsecaseImpl(this._coinRepository);

  @override
  Future<Either<Failure, List<CoinModel>>> call() async{
    return await _coinRepository.getAllCoins();
  }

}