import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/widget/restaurant_card.dart';
import 'package:restaurant_app/widget/madhang_geden_logo.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    FutureBuilder<String> _buildList(BuildContext context) {
      return FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/local_restaurant.json'),
          builder: (context, snapshot) {
            var jsonMap = jsonDecode(snapshot.data!);
            var restaurant = Restaurant.fromJson(jsonMap);
            return Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 530,
                  child: ListView(
                    children: restaurant.restaurants.map((resto) {
                      return RestaurantCard(resto: resto);
                    }).toList(),
                  ),
                ));
          });
    }

    return Scaffold(
      backgroundColor: kRedPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  const MadhangGedenLogo(),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight - 143 - 20,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Recommended',
                          style: poppinsTheme.headline6,
                        ),
                      ),
                      _buildList(context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
