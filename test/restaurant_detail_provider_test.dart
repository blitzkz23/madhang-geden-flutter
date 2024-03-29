import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:http/http.dart' as http;

import 'restaurant_detail_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Restaurant Detail Test', () {
    String jsonResponse = '''
      {
          "error": false,
          "message": "success",
          "restaurant": {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
              "city": "Medan",
              "address": "Jln. Pandeglang no 19",
              "pictureId": "14",
              "rating": 4.2,
              "categories": [
                  {
                      "name": "Italia"
                  },
                  {
                      "name": "Modern"
                  }
              ],
              "menus": {
                  "foods": [
                      {
                          "name": "Paket rosemary"
                      },
                      {
                          "name": "Toastie salmon"
                      },
                      {
                          "name": "Bebek crepes"
                      },
                      {
                          "name": "Salad lengkeng"
                      }
                  ],
                  "drinks": [
                      {
                          "name": "Es krim"
                      },
                      {
                          "name": "Sirup"
                      },
                      {
                          "name": "Jus apel"
                      },
                      {
                          "name": "Jus jeruk"
                      },
                      {
                          "name": "Coklat panas"
                      },
                      {
                          "name": "Air"
                      },
                      {
                          "name": "Es kopi"
                      },
                      {
                          "name": "Jus alpukat"
                      },
                      {
                          "name": "Jus mangga"
                      },
                      {
                          "name": "Teh manis"
                      },
                      {
                          "name": "Kopi espresso"
                      },
                      {
                          "name": "Minuman soda"
                      },
                      {
                          "name": "Jus tomat"
                      }
                  ]
              },
              "customerReviews": [
                  {
                      "name": "Ahmad",
                      "review": "Tidak rekomendasi untuk pelajar!",
                      "date": "13 November 2019"
                  },
                  {
                      "name": "tidak",
                      "review": "mauuu",
                      "date": "7 Februari 2022"
                  }
              ]
          }
      }''';
    final client = MockClient();

    test(
        'Should return restaurant detail if the http call completes successfully',
        () async {
      when(client.get(Uri.parse(
              "https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867")))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      expect(await ApiService(client).restaurantDetail('rqdv5juczeskfw1e867'),
          isA<RestaurantDetail>());
    });
  });
}
