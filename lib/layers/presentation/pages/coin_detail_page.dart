import 'package:crypto_app/layers/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CoinDetailPage extends StatefulWidget {
  final coin;
  const CoinDetailPage({Key? key, required this.coin}) : super(key: key);

  @override
  _CoinDetailPageState createState() => _CoinDetailPageState();
}

class _CoinDetailPageState extends State<CoinDetailPage> {
  String formatCoinName(String name) {
    return name.split('/')[0];
  }

  @override
  Widget build(BuildContext context) {
    final coin = widget.coin;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          formatCoinName(coin.name!),
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            context.goNamed("home");
          },
        ),
      ),
    );
  }
}
