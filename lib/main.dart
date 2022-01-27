import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'common/styles.dart';
import 'page/splash_screen.dart';
import 'page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: FlexThemeData.light(
            scheme: FlexScheme.sakura, textTheme: poppinsTheme),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurantId:
                    ModalRoute.of(context)?.settings.arguments as String,
              )
        });
  }
}
