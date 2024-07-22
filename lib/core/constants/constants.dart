import 'package:flutter/material.dart';

//  Colors ========================================================

Color primaryColor = Color.fromRGBO(143, 148, 251, 1);
Color secondaryColor = Color.fromRGBO(143, 148, 251, .2);
Color bgColor = Color(0xFF212332);
Color wtColor = Colors.white;
Color greenColor = Colors.green;
Color w_grey_Color = Color.fromARGB(255, 209, 209, 209);
Color gryColor = Colors.grey[700]!;
Color redColor = Color.fromARGB(90, 241, 55, 42);
Color bluColor = Color.fromRGBO(84, 92, 255, 1);
Color yalColor = Colors.amber;

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
