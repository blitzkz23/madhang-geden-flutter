import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
