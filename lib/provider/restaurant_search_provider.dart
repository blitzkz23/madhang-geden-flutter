import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/model/restaurant_search.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  RestaurantSearchProvider({required this.query, required this.apiService}) {
    fetchRestaurantSearch(query);
  }

  late RestaurantSearch _restaurantSearchResult;
  late ResultState _state;

  String _message = '';

  RestaurantSearch get result => _restaurantSearchResult;

  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;

      notifyListeners();
      final searchedRestaurant = await apiService.searchRestaurant(query);

      if (searchedRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        return _message = 'Restaurant not found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = searchedRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
