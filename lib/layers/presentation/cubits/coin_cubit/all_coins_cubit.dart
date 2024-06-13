import 'package:crypto_app/layers/domain/usecases/get_all_coins_usecase.dart/get_all_coins_usecase.dart';
import 'package:crypto_app/layers/presentation/cubits/coin_cubit/all_coins_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCoinsCubit extends Cubit<GetAllCoinsState>{
  final GetAllCoinsUsecase _getAllCoinsUsecase;

  AllCoinsCubit(this._getAllCoinsUsecase) : super(GetAllCoinsLoadingState());

  void loadAllCoinsList() async{
    emit(GetAllCoinsLoadingState());
    print("Entrei");
    
    var coinsList = await _getAllCoinsUsecase();

    coinsList.fold(
      (failure) => emit(GetAllCoinsErrorState(failure: failure)), 
      (coinsList) => emit(GetAllCoinsSucessfulState(coinsList: coinsList)),
    );
  }
}