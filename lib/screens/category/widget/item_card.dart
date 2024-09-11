// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, unused_local_variable
// ignore_for_file: sized_box_for_whitespace

import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/places/Places.dart';
import 'package:day12_login/data/model/get_paces_model.dart';
import 'package:day12_login/screens/widgets/images/Custom_Image.dart';
import 'package:flutter/material.dart';

Widget ItemCard(
  context,
  Favorite_Controller pro_Favorite,
  Auth_Provider pro_Auth,
  Places_Controller pro_Places, {
  required String token,
  required String guest,
  required categoryName,
  required Places_Data item,
  required place_id,
  required String id,
  required String img,
}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    height: 120,
    // width: size.width / 1.2,
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: wtColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 30, spreadRadius: 10),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        guest == 'akramaboubakersh@gmail.com'
            ? SizedBox()
            : IconButton(
                onPressed: () async {
                  //

                  await pro_Favorite.add_Favorite(context, token, place_id);
                  await pro_Places.fetch_Places(context, pro_Auth.user!.data!.token!, id);
                },
                icon: Card(
                  color: wtColor,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(Icons.favorite, color: item.favorite == 0 ? gryColor : redColor),
                  ),
                ),
              ),
        Row(
          children: [
            Text(
              categoryName,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(width: 15),
            Custom_Image(h: double.infinity, w: 130, images: img),
          ],
        ),
      ],
    ),
  );
}
