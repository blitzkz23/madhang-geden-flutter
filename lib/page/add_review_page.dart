import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'package:restaurant_app/provider/restaurant_post_review_provider.dart';

class AddReviewPage extends StatefulWidget {
  static const routeName = '/add_review';
  final Restaurant restaurant;
  static String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/small/";

  const AddReviewPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _name = '';
    String _review = '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
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
                      'Tambahkan Ulasan',
                      style: poppinsTheme.headline6
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Image.network(
                AddReviewPage.pictureUrl + widget.restaurant.pictureId,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: Text(
                  'Bagaimana pengalaman Anda dengan ${widget.restaurant.name}?',
                  style: poppinsTheme.headline5
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              _buildFormReviewSection(_name, _review)
            ],
          ),
        ),
      ),
    );
  }

  Consumer<RestaurantPostReviewProvider> _buildFormReviewSection(
      String _name, String _review) {
    return Consumer<RestaurantPostReviewProvider>(
      builder: (context, state, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "Nama: ",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  controller: _nameController,
                  cursorColor: kBlackColor,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Masukkan nama Anda...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: kRedPrimary),
                      )),
                  onChanged: (value) {
                    _name = value;
                    debugPrint(_name);
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text("Review: "),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  controller: _reviewController,
                  maxLines: 3,
                  cursorColor: kBlackColor,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Masukkan sebuah ulasan...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: kRedPrimary),
                      )),
                  onChanged: (value) {
                    _review = value;
                    debugPrint(_review);
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.isNotEmpty &&
                            _reviewController.text.isNotEmpty) {
                          state
                              .postReview(
                            widget.restaurant.id,
                            _nameController.text,
                            _reviewController.text,
                          )
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ulasan berhasil terkirim'),
                              ),
                            );
                            Navigator.pushReplacementNamed(
                                context, DetailPage.routeName,
                                arguments: widget.restaurant.id);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Teks tidak boleh kosong'),
                            ),
                          );
                        }
                      },
                      child: const Text('Tambahkan Ulasan')),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _reviewController.dispose();
  }
}
