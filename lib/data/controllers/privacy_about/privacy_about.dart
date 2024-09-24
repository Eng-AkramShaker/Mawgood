// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/data/model/privacy_policy_about_us_model.dart';
import 'package:day12_login/data/services/privacy_policy_about_api.dart';
import 'package:flutter/material.dart';

class Privacy_About_Controller with ChangeNotifier {
  //

  PrivacyPolicyAboutUsModel? List_Privacy_About;

  // fetch Places =============================================================================================

  fetch_Privacy_About(context, String token) async {
    await Privacy_Policy_About_Api().Get_Privacy_Policy_About_Api(context, token).then((value) {
      List_Privacy_About = value!;
    });

    notifyListeners();
  }
}
