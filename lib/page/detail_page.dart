import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  const DetailPage({Key? key, required this.resto}) : super(key: key);

  final RestaurantElement resto;

  @override
  Widget build(BuildContext context) {
    const double _sigmaX = 0.0;
    const double _sigmaY = 0.0;
    const double _opacity = 0.4;

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
                resto.name,
                style: poppinsTheme.headline5,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  Hero(
                    tag: resto.id,
                    child: Image.network(
                      resto.pictureId,
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
                  resto.name,
                  style: poppinsTheme.headline5
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      resto.city,
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
                          resto.rating.toString(),
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
                  'Description',
                  style: poppinsTheme.headline6,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  resto.description,
                  textAlign: TextAlign.justify,
                  style: poppinsTheme.bodyText1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Foods',
                          style: poppinsTheme.headline6,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: resto.menus.foods.map((food) {
                            return Text("● ${food.name}");
                          }).toList(),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Drinks',
                          style: poppinsTheme.headline6,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: resto.menus.drinks.map((drink) {
                            return Text("● ${drink.name}");
                          }).toList(),
                        )
                      ],
                    )
                  ],
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
