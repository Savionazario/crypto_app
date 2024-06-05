import 'package:crypto_app/layers/core/failure.dart';
import 'package:crypto_app/layers/domain/models/coin_model.dart';
import 'package:crypto_app/layers/domain/usecases/get_all_coins_usecase.dart/get_all_coins_usecase.dart';
import 'package:crypto_app/layers/presentation/cubits/coin_cubit/all_coins_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCoinsCubit extends Cubit<GetAllCoinsState>{
  final GetAllCoinsUsecase _getAllCoinsUsecase;

  AllCoinsCubit(this._getAllCoinsUsecase) : super(GetAllCoinsLoadingState());

  void loadAllCoinsList() async{
    emit(GetAllCoinsLoadingState());
    try {
      print("Entrei");
      List<CoinModel> coinsList = await _getAllCoinsUsecase();

      print("#########: $coinsList");

      emit(GetAllCoinsSucessfulState(coinsList: coinsList));
    } catch (e) {
      print("Erro em loadAllCoinsList: $e");
      emit(GetAllCoinsErrorState(failure: GenericFailure(failureMessage: "Ops, algo deu errado!")));
    }
  }
}