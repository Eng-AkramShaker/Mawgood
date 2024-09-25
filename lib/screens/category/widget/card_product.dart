// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:day12_login/core/constants/app_sizes.dart';
import 'package:day12_login/screens/widgets/containers/empty_%20container.dart';
import 'package:day12_login/screens/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Card_Product extends StatefulWidget {
  const Card_Product({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Card_Product> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height_media(context),
      width: width_media(context),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
                // color: w_grey_Color,
                child: Container_Empty(
              Padding: 5,
              // color: wtColor,
              child: Container(
                // color: wtColor,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/product1.png', width: 21.w, height: 11.h, fit: BoxFit.cover),
                            const SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Custom_Text(text: 'text', size: 15),
                                const SizedBox(height: 8.0),
                                Container_Empty(
                                  Padding: 5,
                                  color: Colors.green[100],
                                  child: Row(
                                    children: [
                                      Custom_Text(text: 'text', size: 15),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.bolt, color: Colors.green),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Custom_Text(text: 'text', size: 15),
                            Custom_Text(text: 'text', size: 15),
                          ],
                        ),
                      ],
                    ),

                    // ===================
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
