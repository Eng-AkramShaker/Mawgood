// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

class Custom_Slider extends StatelessWidget {
  List<CarouselItem> itemList = [
    CarouselItem(
      image: const NetworkImage(
        'https://alrazygroup.com/wp-content/uploads/2024/02/%D8%A7%D9%87%D9%85%D9%8A%D8%A9-%D8%A7%D9%84%D9%83%D8%B4%D9%81-%D8%A7%D9%84%D9%85%D9%86%D8%B2%D9%84%D9%8A-%D9%84%D9%84%D8%A8%D8%A7%D8%B7%D9%86%D8%A9.png.webp',
      ),
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      // leftSubtitle: '11 Feb 2022',
      // rightSubtitle: 'v1.0.0',
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
        'https://admin.dotcarecms.com/storage/AEH/posts/May2024/S6VNzDBOi5kdQ5ryN1SeIQqjkz41AIvPdhXJ5eEl.webp',
      ),
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      // leftSubtitle: '11 Feb 2022',
      // rightSubtitle: 'v1.0.0',
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
        'https://www.elmokattam.to-all.com/wp-content/uploads/2019/08/Internalmedicine_22_11zon.webp',
      ),
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      // leftSubtitle: '11 Feb 2022',
      // rightSubtitle: 'v1.0.0',
      onImageTap: (i) {},
    ),
  ];

  Custom_Slider({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomCarouselSlider(
      items: itemList,
      height: 150,
      width: double.maxFinite,
      subHeight: 0,

      autoplay: true,
      // selectedDotColor: Colors.green,
      // unselectedDotColor: Colors.white,
    );
  }
}
