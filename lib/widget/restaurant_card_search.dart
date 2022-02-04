import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/page/detail_page.dart';

class RestaurantCardSearch extends StatelessWidget {
  final Restaurant resto;
  static String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";

  const RestaurantCardSearch({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: resto.id);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: resto.id,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/loading.gif',
                    image: pictureUrl + resto.pictureId,
                    width: 140,
                  ),
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
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsTheme.headline6
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  resto.city,
                  style: poppinsTheme.subtitle1?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 8,
                ),
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
          )
        ],
      ),
    );
  }
}
