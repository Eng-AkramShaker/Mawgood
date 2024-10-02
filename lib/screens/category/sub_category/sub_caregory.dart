// ignore_for_file: unused_local_variable, unused_element, must_be_immutable

import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/screens/category/places/places_items.dart';
import 'package:day12_login/screens/category/widget/card_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sub_Category_Screen extends StatefulWidget {
  Sub_Category_Screen({
    super.key,
  });

  @override
  State<Sub_Category_Screen> createState() => _Sub_Category_ScreenState();
}

class _Sub_Category_ScreenState extends State<Sub_Category_Screen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<Controller_Home, Favorite_Controller>(
      builder: (context, home_Controller, Favorite_Controller, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(233, 235, 255, 1),
            appBar: AppBar(backgroundColor: Colors.grey[100]),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      _buildProductGrid(home_Controller, Favorite_Controller),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductGrid(Controller_Home home_Controller, Favorite_Controller Favorite_Controller) {
    if (home_Controller.List_Sub_Category.isEmpty) {
      return SizedBox(width: 25, height: 25, child: Center(child: CircularProgressIndicator()));
    } else {
      return Column(
        children: List.generate(
          (home_Controller.List_Sub_Category.length / 2).ceil(),
          (index) {
            final int firstIndex = index * 2;
            final int secondIndex = firstIndex + 1;

            final firstItem = home_Controller.List_Sub_Category[firstIndex];
            final secondItem =
                secondIndex < home_Controller.List_Sub_Category.length ? home_Controller.List_Sub_Category[secondIndex] : null;

            return home_Controller.lodging_sub_category == false
                ? Center(
                    child: Container(width: 25, height: 25, child: CircularProgressIndicator()),
                  )
                : Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              pushNewScreen(context, ShowAllPlaces(id: firstItem.id.toString()));
                            },
                            child: CardDetails(name: firstItem.name!, img: firstItem.imgPath!),
                          ),
                        ),
                        SizedBox(width: 10),
                        secondItem != null
                            ? Expanded(
                                child: InkWell(
                                  onTap: () {
                                    pushNewScreen(context, ShowAllPlaces(id: secondItem.id.toString()));
                                  },
                                  child: CardDetails(name: secondItem.name!, img: secondItem.imgPath!),
                                ),
                              )
                            : Expanded(child: SizedBox()),
                      ],
                    ),
                  );
          },
        ),
      );
    }
  }
}
