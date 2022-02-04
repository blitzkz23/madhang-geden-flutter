import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  static String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";

  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 45,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Hero(
                    tag: restaurant.id,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: 'assets/loading.gif',
                      image: pictureUrl + restaurant.pictureId,
                      width: 140,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
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
                    restaurant.city,
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
            ),
            Expanded(
              flex: 20,
              child: Consumer<DatabaseProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<bool>(
                    future: provider.isFavorited(restaurant.id),
                    builder: (context, snapshot) {
                      var isFavorited = snapshot.data ?? false;
                      return Column(children: [
                        isFavorited
                            ? IconButton(
                                color: kRedPrimary,
                                icon: const Icon(Icons.favorite),
                                onPressed: () {
                                  provider.removeFavorited(restaurant.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${restaurant.name} telah dihapus dari daftar favorit',
                                        style: poppinsTheme.subtitle1
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      backgroundColor: kRedPrimary,
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  provider.addFavorite(restaurant);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      '${restaurant.name} telah ditambahkan ke daftar favorit',
                                      style: poppinsTheme.subtitle1
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    backgroundColor: kRedPrimary,
                                    duration: const Duration(seconds: 1),
                                  ));
                                }),
                      ]);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
