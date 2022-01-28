import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/widget/restaurant_card_search.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController queryController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: poppinsTheme.headline5
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              ChangeNotifierProvider(
                  create: (_) => RestaurantSearchProvider(
                      apiService: ApiService(), query: queryController.text),
                  child: Consumer<RestaurantSearchProvider>(
                      builder: (context, state, _) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: queryController,
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
                          ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            query = value;
                            print(query);
                          });
                          if (value != '') {
                            state.fetchRestaurantSearch(value);
                          }
                        },
                      ),
                    );
                  })),

              /**
               * Provide API for search
               */
              ChangeNotifierProvider(
                create: (_) => RestaurantSearchProvider(
                    apiService: ApiService(), query: queryController.text),
                child: Consumer<RestaurantSearchProvider>(
                  builder: (context, state, _) {
                    query = queryController.text;
                    if (state.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == ResultState.hasData) {
                      state.fetchRestaurantSearch(query);

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          var restaurant = state.result.restaurants[index];
                          return RestaurantCardSearch(resto: restaurant);
                        },
                        shrinkWrap: true,
                        itemCount: state.result.restaurants.length,
                      );
                    } else if (state.state == ResultState.noData) {
                      state.fetchRestaurantSearch(query);

                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state.state == ResultState.error) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return const Center(
                        child: Text(''),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
