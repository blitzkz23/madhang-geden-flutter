import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String _list = "list";
  static const String _detail = "detail";

  Future<RestaurantResult> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list of restaurant');
    }
  }

  Future<RestaurantDetail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + "/" + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail of restaurant');
    }
  }
}
