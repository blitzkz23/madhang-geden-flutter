import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'restaurant_detail_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Restaurant List API Test', () {
    late Restaurant restaurant;
    final client = MockClient();

    setUp(() {
      restaurant = Restaurant(
          id: "rqdv5juczeskfw1e867",
          name: "Melting Pot",
          description:
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
          pictureId: "14",
          city: "Medan",
          rating: 4.2);
    });

    test('Should success parsing json', () {
      var result = Restaurant.fromJson(restaurant.toJson());
      expect(result.name, restaurant.name);
    });

    test(
        'Should return restaurant list if the http call completes successfully',
        () async {
      when(client.get(Uri.parse(ApiService.baseUrl + ApiService.list)))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}',
              200));

      expect(
          await ApiService(client).restaurantList(), isA<RestaurantResult>());
    });
  });
}
