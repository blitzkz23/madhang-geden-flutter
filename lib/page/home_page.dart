import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/page/favorite_page.dart';
import 'package:restaurant_app/page/restaurant_list_page.dart';
import 'package:restaurant_app/page/settings_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const FavoritePage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  final List<Widget> _bottomNavBarItems = [
    const Icon(Icons.restaurant, color: kRedPrimary),
    const Icon(Icons.favorite, color: kRedPrimary),
    const Icon(Icons.settings, color: kRedPrimary),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: kRedPrimary,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }
}
