// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';

Widget custom_img(imagesFile) {
  return Center(
    child: Stack(
      children: [
        imagesFile == null
            ? Image.asset(
                "assets/images/camera.jpg",
                height: 130,
                width: defaultPadding * 18,
                fit: BoxFit.fill,
              )
            : Image.file(
                imagesFile,
                height: 130,
                width: defaultPadding * 18,
                fit: BoxFit.fill,
              ),
        Positioned(
          right: 4,
          top: 10,
          child: ClipOval(
              child: Container(
            padding: EdgeInsets.all(5),
            color: Colors.white,
            child: Icon(
              Icons.edit,
              color: bgColor,
              size: 26,
            ),
          )),
        )
      ],
    ),
  );
}
