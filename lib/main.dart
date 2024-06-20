import 'package:crypto_app/layers/core/injection_container.dart';
import 'package:crypto_app/layers/presentation/pages/coin_detail_page.dart';
import 'package:crypto_app/layers/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  InjectionContainer.init();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

final GoRouter _goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: "home",
      builder: (context, state) => const HomePage(),
      
    ),
    GoRoute(
      path: "/coinDetail",
      name: "coinDetail",
      pageBuilder: (context, state) {
        var coin = state.extra;

        return CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          child: CoinDetailPage(
            coin: coin,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var forwardTween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: curve));
            var reverseTween = Tween(begin: end, end: begin)
                .chain(CurveTween(curve: curve));

            var forwardAnimation = animation.drive(forwardTween);
            var reverseAnimation = secondaryAnimation.drive(reverseTween);

            // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: secondaryAnimation.status == AnimationStatus.forward ? reverseAnimation : forwardAnimation,
              child: child,
            );
          },
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _goRouter,
    );
  }
}
