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
    FutureBuilder<String> _buildList(BuildContext context) {
      return FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/local_restaurant.json'),
          builder: (context, snapshot) {
            late var jsonMap;
            late var restaurant;
            if (snapshot.hasData) {
              jsonMap = jsonDecode(snapshot.data!);
              restaurant = Restaurant.fromJson(jsonMap);
            }
            return Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 470,
                  child: ListView(
                    children: restaurant.restaurants.map<Widget>((resto) {
                      return RestaurantCard(resto: resto);
                    }).toList(),
                  ),
                ));
          });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const MadhangGedenLogo(),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                child: TextFormField(
                  cursorColor: kBlackColor,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Search for a restaurant...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kRedPrimary),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    'Recommended',
                    style: poppinsTheme.headline6?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildList(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
