import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

import 'restaurant_detail_provider_test.mocks.dart';

@GenerateMocks([ApiService, RestaurantDetailProvider])
void main() {
  group('Restaurant Detail Test', () {
    late Restaurant restaurant;
    late ApiService apiService;
    late Category category;
    late Menus menus;
    late CustomerReview customerReview;
    RestaurantDetailProvider restaurantDetailProvider;

    setUp(() {
      apiService = MockApiService();
      restaurantDetailProvider = MockRestaurantDetailProvider();
      category = Category(name: "Italia");
      menus = Menus(foods: [category], drinks: [category]);
      customerReview =
          CustomerReview(name: 'Ahmad', review: 'Mantab', date: '13-12-2019');
      restaurant = Restaurant(
          id: "rqdv5juczeskfw1e867",
          name: "Melting Pot",
          address: "Jln. Pandeglang no 19",
          description:
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
          pictureId: "14",
          city: "Medan",
          rating: 4.2,
          categories: [category],
          menus: menus,
          customerReviews: [customerReview]);
    });

    test('Should return restaurant detail from API', () async {
      when(apiService.restaurantDetail(restaurant.id)).thenAnswer((_) async {
        return RestaurantDetail(
            error: false, message: 'success', restaurant: restaurant);
      });
    });
  });
}
