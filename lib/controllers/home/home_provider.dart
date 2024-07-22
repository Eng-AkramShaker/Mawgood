// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/core/services/category_api.dart';
import 'package:day12_login/core/services/items.dart';
import 'package:day12_login/model/all_category_model.dart';
import 'package:day12_login/model/items_model.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class Controller_Home with ChangeNotifier {
  //

  bool isLodging = false;
  bool Items_lodging = false;

  MotionTabBarController? motionTabBarController;
  List<Datum> allCategories = [];

  List<Product_model> List_Product = [];

  // List<Product_model> List_Product = [];

  // fetch All Categories =============================================================================================

  fetch_Categories(context) async {
    isLodging = false;
    await Class_AllCategories().get_All_Categories_Api(context).then((value) {
      allCategories = value;
    });

    isLodging = true;

    notifyListeners();
  }

  // fetch items =============================================================================================

  fetch_Items(context, String page) async {
    Items_lodging = false;
    await Class_Items().get_Items_Api(context, page).then((value) {
      List_Product = value;
    });

    Items_lodging = true;

    notifyListeners();
  }
}
