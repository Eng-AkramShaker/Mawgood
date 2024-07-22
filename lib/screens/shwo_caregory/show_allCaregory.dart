// ignore_for_file: unused_local_variable, unused_element, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day12_login/controllers/home/home_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/model/all_category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Show_Category_Screen extends StatefulWidget {
  Show_Category_Screen({super.key, required this.List_items});

  List<Datum> List_items;

  @override
  State<Show_Category_Screen> createState() => _Show_Category_ScreenState();
}

class _Show_Category_ScreenState extends State<Show_Category_Screen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Controller_Home>(
      builder: (context, home_Controller, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(233, 235, 255, 1),
            appBar: AppBar(),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCategoryItem(context, widget.List_items),
                      const SizedBox(height: 14),
                      Center(child: Container(width: 25, height: 25, child: CircularProgressIndicator())),
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

  Widget _buildCategoryItem(context, List<Datum> List_items) {
    return SizedBox(
      height: mediaheight(context),
      width: mediawidth(context),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: List_items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          final category = widget.List_items[index];

          return Padding(
            padding: const EdgeInsets.all(6),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 110.0,
                  width: 110.0,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: category.imgPath!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Center(child: Icon(Icons.error, size: 25)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          category.name!,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
