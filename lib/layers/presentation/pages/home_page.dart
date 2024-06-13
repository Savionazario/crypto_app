import 'package:crypto_app/layers/core/assets.dart';
import 'package:crypto_app/layers/core/constants/constants.dart';
import 'package:crypto_app/layers/domain/models/coin_model.dart';
import 'package:crypto_app/layers/presentation/cubits/coin_cubit/all_coins_cubit.dart';
import 'package:crypto_app/layers/presentation/cubits/coin_cubit/all_coins_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
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
    NumberFormat realFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return realFormat.format(number);
  }

  Future<void> _refreshCoinList() async {
    _allCoinsCubit.loadAllCoinsList();
  }

  @override
  void initState() {
    _allCoinsCubit = GetIt.I.get<AllCoinsCubit>();
    _allCoinsCubit.loadAllCoinsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
      body: RefreshIndicator(
        onRefresh: _refreshCoinList,
        color: Colors.black,
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: size.width,
                      child: SvgPicture.asset(
                        Assets.waves,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 327,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              // tileMode: TileMode.repeated,
                              transform: GradientRotation(25),
                              colors: [
                                Color(0xFF6552FE),
                                Color(0xFFFFE6BC),
                                Color(0xFFFFFFFF),
                                // Color(0xFF1D1D1D),
                                // Color(0xFF272727),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AllCoinsCubit, GetAllCoinsState>(
                  bloc: _allCoinsCubit,
                  builder: (context, state) {
                    if (state is GetAllCoinsLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    if (state is GetAllCoinsErrorState) {
                      return Center(
                          child: Text(state.failure.failureMessage));
                    }

                    state = state as GetAllCoinsSucessfulState;
                    List<CoinModel> coinsList = state.coinsList;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: coinsList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0),
                          child: Container(
                            height: 50,
                            // color: Colors.grey,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 12.0),
                                      child: Container(
                                        height: 45,
                                        width: 48,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF202020),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            coinsList[index].iconPath!,
                                            height: 28,
                                            width: 28,
                                            // fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatCoinName(
                                              coinsList[index].name!),
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          coinsList[index].code!,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: secondaryTextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${coinsList[index].pctChange!}%"
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: coinsList[index]
                                                  .pctChange!
                                                  .isNegative
                                              ? negativeNumberColor
                                              : positiveNumberColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      getFormatCoinNumber(
                                          coinsList[index].ask!),
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: secondaryTextColor,
                                        ),
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
        ),
      ),
    );
  }
}
