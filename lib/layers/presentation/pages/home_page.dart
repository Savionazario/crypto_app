import 'package:crypto_app/layers/core/constants/constants.dart';
import 'package:crypto_app/layers/domain/models/coin_model.dart';
import 'package:crypto_app/layers/domain/repositories/coin_repository.dart';
import 'package:crypto_app/layers/presentation/cubits/coin_cubit/all_coins_cubit.dart';
import 'package:crypto_app/layers/presentation/cubits/coin_cubit/all_coins_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AllCoinsCubit _allCoinsCubit;

  String formatCoinName(String name) {
    return name.split('/')[0];
  }

  String getFormatCoinNumber(double number) {
    NumberFormat realFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return realFormat.format(number);
  }

  @override
  void initState() {
    _allCoinsCubit = GetIt.I.get<AllCoinsCubit>();
    _allCoinsCubit.loadAllCoinsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Moedas",
          style: TextStyle(color: textColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            BlocBuilder<AllCoinsCubit, GetAllCoinsState>(
              bloc: _allCoinsCubit,
              builder: (context, state) {
                if (state is GetAllCoinsLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is GetAllCoinsErrorState) {
                  return Center(child: Text(state.failure.failureMessage));
                }

                state = state as GetAllCoinsSucessfulState;
                List<CoinModel> coinsList = state.coinsList;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: coinsList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        height: 50,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 16.0),
                                  child: Icon(
                                    Icons.currency_bitcoin,
                                    color: Colors.white,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatCoinName(coinsList[index].name!),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      coinsList[index].code!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: secondaryTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${coinsList[index].pctChange!}%".toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: coinsList[index].pctChange!.isNegative ? negativeNumberColor : positiveNumberColor,
                                  ),
                                ),
                                Text(
                                  getFormatCoinNumber(coinsList[index].ask!),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: secondaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
