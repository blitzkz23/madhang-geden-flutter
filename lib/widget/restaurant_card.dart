import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/common/styles.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantElement resto;

  const RestaurantCard({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 8, top: 8),
            child: Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  resto.pictureId,
                  width: 140,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resto.name,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsTheme.headline6,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  resto.city,
                  style: poppinsTheme.subtitle1?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
