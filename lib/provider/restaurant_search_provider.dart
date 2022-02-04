import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import 'package:restaurant_app/utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    fetchRestaurantSearch(query);
  }

  late RestaurantSearch _restaurantSearchResult;
  late ResultState _state;

  String _message = '';
  String _query = '';

  RestaurantSearch get result => _restaurantSearchResult;

  String get message => _message;
  String get query => _query;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantSearch(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        _query = query;

        notifyListeners();
        final searchedRestaurant = await apiService.searchRestaurant(query);

        if (searchedRestaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          return _message = 'Restoran tidak ditemukan';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantSearchResult = searchedRestaurant;
        }
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Gagal memuat data, silahkan periksa koneksi internet Anda.';
    }
  }
}
