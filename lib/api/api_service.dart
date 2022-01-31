import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/model/restaurant_post_review.dart';
import 'package:restaurant_app/model/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String _list = "list";
  static const String _detail = "detail";
  static const String _search = "search";
  static const String _review = "review";

  Future<RestaurantResult> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan daftar restoran');
    }
  }

  Future<RestaurantDetail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + "/" + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan detail restoran');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse(_baseUrl + _search + "?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan hasil pencarian restoran');
    }
  }

  Future<RestaurantPostReview> postReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse(_baseUrl + _review),
      body: jsonEncode(<String, String>{
        'id': "rqdv5juczeskfw1e867",
        'name': name,
        'review': review
      }),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return RestaurantPostReview.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Gagal menambahkan ulasan');
    }
  }
}
