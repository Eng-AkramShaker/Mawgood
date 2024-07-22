// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';

Widget ItemCard(context, {required imageUrl, required categoryName}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    height: 90,
    width: size.width / 1.2,
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: wtColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 30,
          spreadRadius: 10,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          categoryName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(width: 40),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 100,
            width: 150,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            errorWidget: (context, url, error) => Center(child: Icon(Icons.error, size: 25)),
          ),
        ),
      ],
    ),
  );
}
