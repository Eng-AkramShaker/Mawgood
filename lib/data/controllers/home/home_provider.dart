// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/model/sliders_model.dart';
import 'package:day12_login/data/services/Sliders_api.dart';
import 'package:day12_login/data/services/category_api.dart';
import 'package:day12_login/data/services/items.dart';
import 'package:day12_login/data/model/all_category_model.dart';
import 'package:day12_login/data/model/items_model.dart';
import 'package:day12_login/screens/category/sub_category/sub_caregory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:provider/provider.dart';

class Controller_Home with ChangeNotifier {
  //

  bool isLodging = false;
  bool Items_lodging = false;
  bool lodging_sub_category = false;
  MotionTabBarController? motionTabBarController;
  List<Datum> allCategories = [];
  List<Product_model> List_Product = [];
  List<Product_model> List_Sub_Category = [];

// Sliders  ===================================

  SlidersModel? List_Sliders;
  List<CarouselItem> itemList = [];

  // fetch All Categories =====================================================================================

  fetch_Categories(context) async {
    final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);

    isLodging = false;
    await Class_AllCategories().get_All_Categories_Api(context, pro_Auth.user!.data!.token!).then((value) {
      allCategories = value;
    });

    isLodging = true;

    notifyListeners();
  }

  // fetch items =============================================================================================

  fetch_Items(context, String page) async {
    final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);

    Items_lodging = false;
    await Class_Items().get_Items_Api(context, pro_Auth.user!.data!.token!, page).then((value) {
      List_Product = value;
    });

    Items_lodging = true;

    notifyListeners();
  }

  // fetch items =============================================================================================

  fetch_sliders(context, String token) async {
    await Sliders_Api().fetch_Sliders_Api(context, token).then((value) {
      List_Sliders = value;

      if (List_Sliders != null) {
        for (var i = 0; i < List_Sliders!.data.length; i++) {
          itemList.add(
            CarouselItem(
              image: NetworkImage(List_Sliders!.data[i].imgPath!),
              titleTextStyle: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          );
        }
      }
    });

    notifyListeners();
  }

  //  Sub_Category =============================================================================================

  fetch_Sub_Category(context, String page) async {
    final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);

    lodging_sub_category = false;

    List_Sub_Category = [];
    await Class_Items().get_Items_Api(context, pro_Auth.user!.data!.token!, page).then((value) {
      List_Sub_Category = value;

      if (List_Sub_Category.isNotEmpty) {
        pushNewScreen(context, Sub_Category_Screen());
      }
    });

    lodging_sub_category = true;

    notifyListeners();
  }
}
