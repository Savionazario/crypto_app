import 'package:crypto_app/layers/data/datasources/coin_datasource.dart';
import 'package:crypto_app/layers/data/datasources/remote/coin_remote_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockIconService mockIconService;
  late CoinDatasource coinRemoteDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    mockIconService = MockIconService();
    coinRemoteDataSourceImpl = CoinRemoteDatasourceImpl(mockIconService, mockDio);
  });

  // test(description, body);
}
