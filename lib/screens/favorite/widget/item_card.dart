// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/model/get_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget custom_item(context, {required Favorite List_Favorite, required onPressed}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    height: 90,
    width: size.width,
    decoration: BoxDecoration(
      color: wtColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 30, spreadRadius: 10),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: List_Favorite.place!.media.isEmpty ? "https://i.suar.me/ONn/l" : List_Favorite.place!.media[0].img_path!,
                  height: 80,
                  width: 110,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error, size: 25)),
                ),
              ),
              //
              SizedBox(width: 10),
              Text(
                List_Favorite.place!.name!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor),
              ),
            ],
          ),

          IconButton(
            onPressed: onPressed,
            icon: Card(
              child: Padding(padding: const EdgeInsets.all(5), child: Icon(Icons.favorite, color: redColor)),
            ),
          ),
        ],
      ),
    ),
  );
}
