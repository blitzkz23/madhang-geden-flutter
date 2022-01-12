import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final double _sigmaX = 0.0;
  final double _sigmaY = 0.0;
  final double _opacity = 0.4;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'images/resto_splash.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                child: Container(
                  color: Colors.black.withOpacity(_opacity),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/madhang_geden_logo.png'),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Find recommended restaurant near your area.',
                  style: poppinsTheme.subtitle1?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
