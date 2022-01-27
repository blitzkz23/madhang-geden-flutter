import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  static String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";

  const DetailPage({Key? key, required this.restaurantId}) : super(key: key);

  final String restaurantId;

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
          apiService: ApiService(), restaurantId: restaurantId),
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
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Text(state.message),
            );
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
                  expandedAlignment: Alignment.centerLeft,
                  title: Text('Drink', style: poppinsTheme.headline6),
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Ulasan',
                  style: poppinsTheme.headline6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurant.customerReviews.map((review) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 2.0, right: 2.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.name,
                                style: poppinsTheme.headline6,
                              ),
                              Text(
                                review.date,
                                style: poppinsTheme.subtitle1
                                    ?.copyWith(color: kGreyColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                review.review,
                                style: poppinsTheme.subtitle1,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
