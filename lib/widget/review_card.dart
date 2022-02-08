import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class ReviewCard extends StatelessWidget {
  final Restaurant restaurant;

  const ReviewCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: restaurant.customerReviews.map((review) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 2.0, right: 2.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
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
                    style: poppinsTheme.subtitle1?.copyWith(color: kGreyColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    review.review,
                    style: poppinsTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
