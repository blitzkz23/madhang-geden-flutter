import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/page/restaurant_list_section.dart';
import 'package:restaurant_app/page/search_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/madhang_geden_logo.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            /**
             * Provide API service with provide to RestaurantListSection class
             */
            ChangeNotifierProvider(
              create: (_) => RestaurantProvider(apiService: ApiService()),
              child: const RestaurantListSection(),
            ),
          ],
        ),
      ),
    );
  }
}
