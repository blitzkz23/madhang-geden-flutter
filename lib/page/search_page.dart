import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/restaurant_card_search.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController queryController = TextEditingController();
  late String _query = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kWhiteColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Cari Restoran',
                        style: poppinsTheme.headline6
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SizedBox(
                      child: TextFormField(
                        cursorColor: kBlackColor,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Cari restoran favoritmu...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: kRedPrimary),
                            )),
                        onChanged: (value) {
                          _query = value;
                          debugPrint(_query);
                          state.fetchRestaurantSearch(_query);
                          _buildList(context, state);
                        },
                        onFieldSubmitted: (value) {
                          state.fetchRestaurantSearch(_query);
                          _buildList(context, state);
                        },
                      ),
                    ),
                  ),
                  _query.isNotEmpty
                      ? _buildList(context, state)
                      : Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.search,
                                    size: 80,
                                  ),
                                  Text(
                                    'Silahkan lakukan pencarian untuk menampilkan restoran...',
                                    textAlign: TextAlign.center,
                                    style: poppinsTheme.caption?.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, RestaurantSearchProvider state) {
    final _size = MediaQuery.of(context).size;

    if (state.state == ResultState.loading) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset('assets/88404-loading-bubbles.json'),
            ),
          ],
        ),
      );
    } else if (state.state == ResultState.hasData) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: _size.height * 0.702,
          child: ListView.builder(
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return RestaurantCardSearch(resto: restaurant);
            },
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
          ),
        ),
      );
    } else if (state.state == ResultState.noData) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/error.json'),
            Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: poppinsTheme.headline6,
              ),
            ),
          ],
        ),
      );
    } else if (state.state == ResultState.error) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/error.json'),
            Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: poppinsTheme.headline6,
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text(''),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    queryController.dispose();
  }
}
