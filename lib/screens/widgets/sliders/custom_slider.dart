// ignore_for_file: must_be_immutable, camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Custom_Slider(BuildContext context, List<Widget> itemList) {
  return CarouselSlider(
    options: CarouselOptions(
      height: 280,
      viewportFraction: 1.0,
      autoPlay: false, // تعطيل التمرير التلقائي
      enableInfiniteScroll: false, // تعطيل التمرير اللانهائي
      scrollPhysics: ClampingScrollPhysics(), // تمكين التمرير اليدوي فقط
    ),
    items: itemList,
  );
}
