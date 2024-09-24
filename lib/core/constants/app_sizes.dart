// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
//

//  Size ========================================================

double default_Padding = 5.h;

// =========================================================

double width_media(BuildContext context) {
  double reswidth = MediaQuery.sizeOf(context).width;
  return reswidth;
}

double height_media(BuildContext context) {
  double resheight = MediaQuery.sizeOf(context).height;
  return resheight;
}
