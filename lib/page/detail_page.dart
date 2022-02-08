import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/page/add_review_page.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/review_card.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String restaurantId;
  static String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";

  const DetailPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final String restaurantId = widget.restaurantId;

  @override
  Widget build(BuildContext context) {
    const double _sigmaX = 0.0;
    const double _sigmaY = 0.0;
    const double _opacity = 0.4;

    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(
          apiService: ApiService(Client()), restaurantId: restaurantId),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.hasData) {
            var restaurant = state.result.restaurant;
            return _buildDetailPage(restaurant, _sigmaX, _sigmaY, _opacity);
          } else if (state.state == ResultState.noData) {
            return Scaffold(
                body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/error.json'),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: poppinsTheme.headline6,
                  ),
                ],
              ),
            ));
          } else if (state.state == ResultState.error) {
            return Scaffold(
                body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/error.json'),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: poppinsTheme.headline6,
                  ),
                ],
              ),
            ));
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }

  Scaffold _buildDetailPage(
      Restaurant restaurant, double _sigmaX, double _sigmaY, double _opacity) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: false,
              expandedHeight: 200,
              pinned: true,
              title: Text(
                restaurant.name,
                style: poppinsTheme.headline5,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  Hero(
                    tag: restaurant.id,
                    child: Image.network(
                      DetailPage.pictureUrl + restaurant.pictureId,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        color: Colors.black.withOpacity(_opacity),
                      ),
                    ),
                  ),
                  // Consumer<DatabaseProvider>(
                  //   builder: (context, provider, child) {
                  //     return FutureBuilder<bool>(
                  //       future: provider.isFavorited(restaurant.id),
                  //       builder: (context, snapshot) {
                  //         var isFavorited = snapshot.data ?? false;
                  //         return Positioned(
                  //           bottom: 20,
                  //           right: 20,
                  //           child: isFavorited
                  //               ? FloatingActionButton(
                  //                   backgroundColor: kWhiteColor,
                  //                   onPressed: () =>
                  //                       provider.removeFavorited(restaurant.id),
                  //                   child: const Icon(Icons.favorite),
                  //                 )
                  //               : FloatingActionButton(
                  //                   backgroundColor: kWhiteColor,
                  //                   onPressed: () =>
                  //                       provider.addFavorite(restaurant),
                  //                   child: const Icon(Icons.favorite_border),
                  //                 ),
                  //         );
                  //       },
                  //     );
                  //   },
                  // )
                ]),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: poppinsTheme.headline5
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      restaurant.city,
                      style: poppinsTheme.subtitle1?.copyWith(
                        fontSize: 16,
                        color: kGreyColor,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade700,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: poppinsTheme.subtitle1?.copyWith(
                              color: kBlackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Deskripsi',
                  style: poppinsTheme.headline6,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: poppinsTheme.bodyText1,
                ),
                const SizedBox(
                  height: 12,
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.all(0),
                  childrenPadding: const EdgeInsets.only(bottom: 8.0),
                  expandedAlignment: Alignment.centerLeft,
                  title: Text('Makanan', style: poppinsTheme.headline6),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: restaurant.menus.foods.map((food) {
                        return Text(
                          "● ${food.name}",
                          style: poppinsTheme.bodyText1,
                        );
                      }).toList(),
                    )
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.all(0),
                  childrenPadding: const EdgeInsets.only(bottom: 16.0),
                  expandedAlignment: Alignment.centerLeft,
                  title: Text('Minuman', style: poppinsTheme.headline6),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: restaurant.menus.drinks.map((drink) {
                        return Text(
                          "● ${drink.name}",
                          style: poppinsTheme.bodyText1,
                        );
                      }).toList(),
                    )
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.all(0),
                  childrenPadding: const EdgeInsets.only(bottom: 8.0),
                  title: Text('Ulasan', style: poppinsTheme.headline6),
                  children: [
                    ReviewCard(
                      restaurant: restaurant,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AddReviewPage.routeName,
                          arguments: restaurant);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Tambah Ulasan',
                          style: poppinsTheme.headline6
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
