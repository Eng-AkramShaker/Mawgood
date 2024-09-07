// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/data/model/get_paces_model.dart';
import 'package:day12_login/data/model/one_Item_model.dart';
import 'package:day12_login/data/services/places_api.dart';
import 'package:day12_login/data/services/rating.dart';
import 'package:flutter/material.dart';

class Places_Controller with ChangeNotifier {
  //

  List<Places_Data>? List_All_Places;

  OneItemModel? one_item;

  bool is_loading = false;

  int ReviewCount = 1;

  // fetch All Places =============================================================================================

  fetch_Places(context, String token, String id) async {
    await Places_Api().Get_Places_Api(context, token, id).then((value) {
      List_All_Places = value!.data;
    });

    notifyListeners();
  }

  // fetch one item =============================================================================================

  fetch_one_item(context, String token, String index_id, String show_id) async {
    print(index_id);
    print(show_id);

    is_loading = true;
    await Places_Api().Get_one_Item_Api(context, token, index_id, show_id).then((value) {
      try {
        one_item = value!;
        if (one_item!.data!.reviews.isEmpty) {
          ReviewCount = 1;
        } else {
          ReviewCount = one_item!.data!.reviews.length;
        }
        is_loading = false;
      } catch (e) {}

      print(one_item);
    });

    notifyListeners();
  }

  // fetch one item =============================================================================================

  Send_Rating(context, String token, String place_id, String rating) async {
    print(place_id);
    print(rating);

    await Rating_Api().Send_Rating_Api(context, token, place_id, rating);

    notifyListeners();
  }

  // ==============================================================================================

  double parseAvgRating(avgRating) {
    if (avgRating == null || avgRating == 'null') {
      return 1.0; // Default value if parsing fails
    }

    final parsed = double.tryParse(avgRating.toString());
    return parsed != null && parsed.isFinite ? parsed : 1.0; // Default value if parsed value is invalid
  }
}
