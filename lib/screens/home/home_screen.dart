import 'package:day12_login/controllers/auth/auth_provider.dart';
import 'package:day12_login/core/constants.dart';
import 'package:day12_login/screens/widgets/app_bar_widget.dart';
import 'package:day12_login/screens/widgets/card_details.dart';
import 'package:day12_login/screens/widgets/carousel_images.dart';
import 'package:day12_login/screens/widgets/category_list.dart';
import 'package:day12_login/screens/widgets/text_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth_Provider>(builder: (context, prov_auth, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(233, 235, 255, 1),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AppBarWidget(name: prov_auth.user!.data!.name),
                  const SizedBox(height: 14),
                  const TextFeildWidget(),
                  const SizedBox(height: 14),
                  CarouselImages(),
                  const SizedBox(height: 14),
                  CategoryList(),
                  // const SizedBox(height: 4),
                  SizedBox(
                    height: mediaheight(context),
                    width: mediawidth(context),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two columns
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.1, // Square items
                      ),
                      itemBuilder: (context, index) {
                        return CardDetails();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class Product {
  final String name;
  final String imageUrl;
  final double price;
  final double rating;

  Product(
    this.name,
    this.imageUrl,
    this.price,
    this.rating,
  );
}

List<Product> products = [
  Product("Shirt", "assets/images/p4.jpg", 29.99, 4.5),
  Product("Shoes", "assets/images/p3.jpg", 49.99, 4.2),
  Product("Shoes", "assets/images/p3.jpg", 49.99, 4.2),
  Product("Shoes", "assets/images/p3.jpg", 49.99, 4.2),
  Product("Shoes", "assets/images/p3.jpg", 49.99, 4.2),
  Product("Shoes", "assets/images/p3.jpg", 49.99, 4.2),
  Product("Shirt", "assets/images/p4.jpg", 29.99, 4.5),
  Product("Shoes", "assets/images/p3.jpg", 49.99, 4.2),
  Product("Shoes", "assets/images/p3.jpg", 49.99, 4.2),
  Product("Shoes", "assets/images/p3.jpg", 49.99, 4.2),
];
