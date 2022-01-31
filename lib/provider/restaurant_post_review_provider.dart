import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/model/restaurant_post_review.dart';

enum PostResultState { loading, hasData, noData, error }

class RestaurantPostReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantPostReviewProvider({required this.apiService}) {
    postReview(id, name, review);
  }

  late RestaurantPostReview _reviewResult;
  late PostResultState _state;
  String _message = '';
  String _id = '';
  String _name = '';
  String _review = '';

  RestaurantPostReview get result => _reviewResult;
  PostResultState get state => _state;
  String get message => _message;
  String get id => _id;
  String get name => _name;
  String get review => _review;

  Future<dynamic> postReview(String id, String name, String review) async {
    try {
      if (id.isNotEmpty && name.isNotEmpty && review.isNotEmpty) {
        _state = PostResultState.loading;
        _id = id;
        _name = name;
        _review = review;

        notifyListeners();
        final customerReview = await apiService.postReview(id, name, review);

        if (customerReview.customerReviews.isEmpty) {
          _state = PostResultState.noData;
          return _message = "Ulasan tidak berhasil ditambahkan.";
        } else {
          _state = PostResultState.hasData;
          notifyListeners();
          return _reviewResult = customerReview;
        }
      }
    } catch (e) {
      _state = PostResultState.error;
      notifyListeners();
      return _message =
          'Gagal menambahkan ulasan, silahkan periksa koneksi internet Anda. $e';
    }
  }
}
