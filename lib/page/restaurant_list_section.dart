import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/restaurant_card.dart';

class RestaurantListSection extends StatefulWidget {
  const RestaurantListSection({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantListSection> createState() => _RestaurantListSectionState();
}

class _RestaurantListSectionState extends State<RestaurantListSection> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
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
          height: _size.height * 0.715,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: _buildList(),
          ),
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
        return Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return RestaurantCard(resto: restaurant);
                  },
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                ),
              ),
            ),
          ],
        );
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Column(
            children: [
              Lottie.asset('assets/error.json'),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: poppinsTheme.headline6,
              ),
            ],
          ),
        );
      } else if (state.state == ResultState.error) {
        return Center(
          child: Column(
            children: [
              Lottie.asset('assets/error.json'),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: poppinsTheme.headline6,
              ),
            ],
          ),
        );
      } else {
        return const Center(
          child: Text(''),
        );
      }
    },
  );
}
