// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/data/services/contact_us.dart';
import 'package:flutter/material.dart';

class Contact_us_Controller with ChangeNotifier {
  //

  // fetch Places =============================================================================================

  Send_Contact_us(BuildContext context, String token, String name, String email, String phone, String subject, String message) async {
    await Contact_us_Api().Send_Contact_us_Api(context, token, name, email, phone, subject, message);
  }
}
