import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurantId}) {
    _fetchRestaurantDetail(restaurantId);
  }

  late RestaurantDetail _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  RestaurantDetail get result => _restaurantDetailResult;

  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(restaurantId);

      if (restaurantDetail.restaurant == '') {
        _state = ResultState.noData;
        return _message = 'Restaurant not found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}