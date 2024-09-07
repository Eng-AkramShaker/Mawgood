// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget Auto_Slider(BuildContext context, List<CarouselItem> itemList) {
  return CustomCarouselSlider(
    items: itemList,
    height: 30.h,
    width: double.maxFinite,
    subHeight: 80.h,

    autoplay: true,
    // selectedDotColor: Colors.green,
    // unselectedDotColor: Colors.white,
  );
}
