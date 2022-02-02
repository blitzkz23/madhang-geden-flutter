import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/page/add_review_page.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/page/search_page.dart';
import 'package:restaurant_app/provider/restaurant_post_review_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'common/styles.dart';
import 'model/restaurant_detail.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<RestaurantPostReviewProvider>(
          create: (_) => RestaurantPostReviewProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
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
                ),
            SearchPage.routeName: (context) => const SearchPage(),
            AddReviewPage.routeName: (context) => AddReviewPage(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant,
                ),
          }),
    );
  }
}
