import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_post_review.dart';

class ApiService {
  static const String baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String list = "list";
  static const String detail = "detail";
  static const String _search = "search";
  static const String _review = "review";

  final http.Client client;
  ApiService(this.client);

  Future<RestaurantResult> restaurantList() async {
    final response = await client.get(Uri.parse(baseUrl + list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan daftar restoran');
    }
  }

  Future<RestaurantDetail> restaurantDetail(String id) async {
    final response = await client.get(Uri.parse(baseUrl + detail + "/" + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan detail restoran');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    final response =
        await client.get(Uri.parse(baseUrl + _search + "?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan hasil pencarian restoran');
    }
  }

  Future<RestaurantPostReview> postReview(
      String id, String name, String review) async {
    final response = await client.post(
      Uri.parse(baseUrl + _review),
      body: <String, String>{'id': id, 'name': name, 'review': review},
    );

    if (response.statusCode == 200) {
      debugPrint('response.statusCode: ${response.statusCode}');
      debugPrint(response.body);
      return RestaurantPostReview.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('response.statusCode: ${response.statusCode}');
      debugPrint(response.body);
      throw Exception('Gagal menambahkan ulasan');
    }
  }
}
