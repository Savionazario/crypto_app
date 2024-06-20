
import 'package:crypto_app/layers/domain/repositories/coin_repository.dart';
import 'package:crypto_app/layers/domain/services/icon_service.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    CoinRepository,
    Dio,
    IconService
  ],
)

void main (){}