import 'package:crypto_app/layers/data/repositories/coin_repository_impl.dart';
import 'package:crypto_app/layers/data/services/icon_service_impl.dart';
import 'package:crypto_app/layers/domain/repositories/coin_repository.dart';
import 'package:crypto_app/layers/domain/services/icon_service.dart';
import 'package:crypto_app/layers/domain/usecases/get_all_coins_usecase.dart/get_all_coins_usecase.dart';
import 'package:crypto_app/layers/domain/usecases/get_all_coins_usecase.dart/get_all_coins_usecase_impl.dart';
import 'package:crypto_app/layers/presentation/cubits/coin_cubit/all_coins_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class InjectionContainer {
  static void init() {
    GetIt getIt = GetIt.instance;

    getIt.registerLazySingleton<Dio>(
      () => Dio(),
    ); 

    //! Services
    getIt.registerLazySingleton<IconService>(
      () => IconServiceImpl(),
    );

    //! Repositories
    getIt.registerLazySingleton<CoinRepository>(
      () => CoinRepositoryImpl(getIt(), getIt()),
    );

    //! Usecases
    getIt.registerLazySingleton<GetAllCoinsUsecase>(
      () => GetAllCoinsUsecaseImpl(getIt()),
    );

    //! Cubits
    getIt.registerLazySingleton<AllCoinsCubit>(
      () => AllCoinsCubit(getIt()),
    );
  }
}
