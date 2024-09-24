// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';

Widget Custom_Image({required double h, required double w, required String images}) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    child: images.isEmpty
        ? Image.asset("assets/images/empty.jpg", height: h, width: w, fit: BoxFit.fill)
        : Image.network(images, height: h, width: w, fit: BoxFit.fill),
  );
}
