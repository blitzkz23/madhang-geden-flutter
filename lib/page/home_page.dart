import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/page/restaurant_list_section.dart';
import 'package:restaurant_app/page/search_page.dart';
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
                    onPressed: () {
                      Navigator.pushNamed(context, SearchPage.routeName);
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const RestaurantListSection(),
          ],
        ),
      ),
    );
  }
}
