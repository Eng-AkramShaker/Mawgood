// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Text Custom_Text({required text, required double size, color, fontweight, bool underline = false}) {
  return Text(
    text ?? '',
    style: TextStyle(
      color: color ?? Colors.white,
      fontSize: size ?? 19,
      fontWeight: fontweight ?? FontWeight.normal,
      fontFamily: 'Lemonada',
      decoration: underline == true ? TextDecoration.underline : TextDecoration.none,
    ),
  );
}
