import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([ApiService, RestaurantProvider])
void main() {
  group('Restaurant List API Test', () {
    late Restaurant restaurant;
    late ApiService apiService;
    RestaurantProvider restaurantProvider;
    late List<Restaurant> restaurants;

    setUp(() {
      apiService = MockApiService();
      restaurantProvider = MockRestaurantProvider();
      restaurant = Restaurant(
          id: "rqdv5juczeskfw1e867",
          name: "Melting Pot",
          description:
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
          pictureId: "14",
          city: "Medan",
          rating: 4.2);
      restaurants = [restaurant];
    });

    test('Should success parsing json', () {
      var result = Restaurant.fromJson(restaurant.toJson());
      expect(result.name, restaurant.name);
    });

    test('Should return restaurant list from API', () async {
      when(apiService.restaurantList()).thenAnswer((_) async {
        return RestaurantResult(
          error: false,
          message: 'success',
          count: 20,
          restaurants: restaurants,
        );
      });
    });
  });
}
