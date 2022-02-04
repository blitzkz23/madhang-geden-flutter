import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_post_review.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantPostReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantPostReviewProvider({required this.apiService}) {
    postReview(id, name, review);
  }

  late RestaurantPostReview _reviewResult;
  late ResultState _state;
  String _message = '';
  String _id = '';
  String _name = '';
  String _review = '';

  RestaurantPostReview get result => _reviewResult;
  ResultState get state => _state;
  String get message => _message;
  String get id => _id;
  String get name => _name;
  String get review => _review;

  Future<dynamic> postReview(String id, String name, String review) async {
    try {
      if (id.isNotEmpty && name.isNotEmpty && review.isNotEmpty) {
        _state = ResultState.loading;
        _id = id;
        _name = name;
        _review = review;

        notifyListeners();
        final customerReview = await apiService.postReview(id, name, review);

        if (customerReview.customerReviews.isEmpty) {
          _state = ResultState.noData;
          return _message = "Ulasan tidak berhasil ditambahkan.";
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _reviewResult = customerReview;
        }
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Gagal menambahkan ulasan, silahkan periksa koneksi internet Anda. $e';
    }
  }
}
