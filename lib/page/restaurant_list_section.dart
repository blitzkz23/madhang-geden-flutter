import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/restaurant_card.dart';

class RestaurantListSection extends StatelessWidget {
  const RestaurantListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restoran Terdekat',
                style: poppinsTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Restoran terdekat dari lokasimu sekarang',
                style: poppinsTheme.subtitle1?.copyWith(color: kGreyColor),
              )
            ],
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildList(),
          ),
          height: 570,
        ),
      ],
    );
  }
}

Widget _buildList() {
  return Consumer<RestaurantProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return RestaurantCard(resto: restaurant);
          },
          shrinkWrap: true,
          itemCount: state.result.restaurants.length,
        );
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
  );
}
