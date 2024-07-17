import 'package:flutter/material.dart';

//  Colors ========================================================

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const wtColor = Colors.white;
const greenColor = Colors.green;
const w_grey_Color = Color.fromARGB(71, 255, 255, 255);
const gryColor = Color.fromARGB(54, 201, 216, 70);
const redColor = Color.fromARGB(90, 241, 55, 42);
const bluColor = Color.fromARGB(90, 29, 149, 247);
const yalColor = Colors.amber;

//  Size ========================================================

const defaultPadding = 16.0;

double mediawidth(BuildContext context) {
  double reswidth = MediaQuery.sizeOf(context).width;
  return reswidth;
}

double mediaheight(BuildContext context) {
  double resheight = MediaQuery.sizeOf(context).height;
  return resheight;
}
