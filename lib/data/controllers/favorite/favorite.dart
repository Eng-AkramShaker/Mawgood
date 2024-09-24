// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/data/services/favorite.dart';
import 'package:flutter/material.dart';

class Favorite_Controller with ChangeNotifier {
  //

  // Add Favorite =============================================================================================

  add_Favorite(context, String token, String placeId) async {
    await class_Favorite_api().Add_Favorite_api(context, token, placeId).then((val) {
      notifyListeners();
    });
  }

  // fetch Favorite =============================================================================================

  delete_Favorite(context, Profile_Provider pro_Profile, String token, String placeId) async {
    notifyListeners();
    await class_Favorite_api().Delete_Favorite_api(context, token.toString(), placeId);

    await pro_Profile.fetch_Profile(context, token);
  }
}
