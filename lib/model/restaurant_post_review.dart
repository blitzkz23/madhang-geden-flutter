import 'dart:convert';

RestaurantPostReview restaurantPostReviewFromJson(String str) =>
    RestaurantPostReview.fromJson(json.decode(str));

String restaurantPostReviewToJson(RestaurantPostReview data) =>
    json.encode(data.toJson());

class RestaurantPostReview {
  RestaurantPostReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReview> customerReviews;

  factory RestaurantPostReview.fromJson(Map<String, dynamic> json) =>
      RestaurantPostReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class CustomerReview {
  CustomerReview({
    required this.id,
    required this.name,
    required this.review,
  });

  String id;
  String name;
  String review;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
