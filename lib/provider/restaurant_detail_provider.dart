import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurantId}) {
    fetchRestaurantDetail(restaurantId);
  }

  late RestaurantDetail _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  RestaurantDetail get result => _restaurantDetailResult;

  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> fetchRestaurantDetail(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(restaurantId);

      if (restaurantDetail.error) {
        _state = ResultState.noData;
        return _message = 'Data tidak tersedia.';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Gagal memuat data, silahkan periksa koneksi internet Anda.';
    }
  }
}
