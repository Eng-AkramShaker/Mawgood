// ignore_for_file: unused_local_variable, unused_element, must_be_immutable, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/model/all_category_model.dart';
import 'package:day12_login/screens/category/sub_category/sub_caregory.dart';
import 'package:day12_login/screens/widgets/card_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class All_Show_Category_Screen extends StatefulWidget {
  All_Show_Category_Screen({super.key, required this.List_items});

  List<Datum> List_items;

  @override
  State<All_Show_Category_Screen> createState() => _Show_Category_ScreenState();
}

class _Show_Category_ScreenState extends State<All_Show_Category_Screen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Controller_Home>(
      builder: (context, home_Controller, child) {
        Size size = MediaQuery.of(context).size;

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
                      widget.List_items != null
                          ? _buildCategoryItem(context, home_Controller, widget.List_items)
                          : Center(child: Container(width: 25, height: 25, child: CircularProgressIndicator())),
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

  Widget _buildCategoryItem(context, Controller_Home home_Controller, List<Datum> List_items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: (List_items.length / 2).ceil(),
      itemBuilder: (context, index) {
        final item1 = List_items[index * 2];
        final item2 = (index * 2 + 1 < List_items.length) ? List_items[index * 2 + 1] : null;

        return Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                    onTap: () async {
                      await home_Controller.fetch_Sub_Category(context, item1.id.toString());
                    },
                    child: CardDetails(name: item1.name!, img: item1.imgPath!)),
              ),
              const SizedBox(width: 10),
              if (item2 != null)
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        await home_Controller.fetch_Sub_Category(context, item2.id.toString());
                      },
                      child: CardDetails(name: item2.name!, img: item2.imgPath!)),
                )
              else
                Expanded(child: Spacer()),
            ],
          ),
        );
      },
    );
  }
}
