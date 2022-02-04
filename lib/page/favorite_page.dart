import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/restaurant_card.dart';

class FavoritePage extends StatefulWidget {
  static const String pageTitle = 'Favorites';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Restoran Favorit',
                style: poppinsTheme.headline5
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Consumer<DatabaseProvider>(
              builder: (context, provider, child) {
                if (provider.state == ResultState.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                          restaurant: provider.favorites[index],
                        );
                      },
                      itemCount: provider.favorites.length,
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset('assets/closed-tag.json'),
                        Text(
                          'Anda belum memiliki restoran favorit',
                          textAlign: TextAlign.center,
                          style: poppinsTheme.headline6,
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
