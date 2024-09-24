import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';

Text Custom_Text(
    {required text,
    required double size,
    color,
    fontweight,
    bool underline = false}) {
  return Text(
    text ?? '',
    style: TextStyle(
      color: color ?? bgColor,
      fontSize: size ?? 19,
      fontWeight: fontweight ?? FontWeight.normal,
      fontFamily: 'Lemonada',
      decoration:
          underline == true ? TextDecoration.underline : TextDecoration.none,
    ),
  );
}
