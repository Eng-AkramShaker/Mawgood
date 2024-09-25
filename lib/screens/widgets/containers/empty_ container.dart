// ignore_for_file: non_constant_identifier_names, file_names

import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';

Widget Container_Empty({double? h, double? w, required double Padding, required Widget child, Color? color, bool border = false}) {
  return Container(
    height: h,
    width: w,
    padding: EdgeInsets.all(Padding),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(7)),
      border: border ? Border.all(color: gryColor) : null,
    ),
    child: Center(
      child: child,
    ),
  );
}
