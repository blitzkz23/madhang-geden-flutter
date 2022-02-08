import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Belum ada restoran favorit';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorites(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = "Gagal menambahkan restoran ke daftar favorit.";
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoritesById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorited(String id) async {
    try {
      await databaseHelper.removeFavorited(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = "Gagal menghapus restoran dari daftar favorit.";
      debugPrint(e.toString());
      notifyListeners();
    }
  }
}
