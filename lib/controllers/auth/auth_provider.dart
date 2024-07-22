// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/main.dart';
import 'package:day12_login/model/sign_in_model.dart';
import 'package:day12_login/screens/auth_screens/sign_In.dart';
import 'package:day12_login/screens/home/home.dart';
import 'package:day12_login/screens/widgets/snack_bar/Snack_Bar.dart';
import 'package:day12_login/core/services/auth_api.dart';
import 'package:flutter/material.dart';

class Auth_Provider with ChangeNotifier {
  //

  SignIn? user;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cPassword = TextEditingController();

//  Sign In  ============================================

  Future<String?> Sign_In(BuildContext context) async {
    SignIn? data = await Auth_Api().SignIn_Api(context, email.text, pass.text);

    if (data != null && data.success == true) {
      user = data;
      await Snak_Bar(context, "تم تسجيل الدخول بنجاح");

      notifyListeners();

      pushNewScreen(context, MyHomePage());

      return data.message;
    } else {
      await Snak_Bar(context, "تأكد من الايميل أو كلمه المرور  ");
      return null;
    }
  }

  //  Sign Up  ============================================

  Future<String?> Sign_Up(BuildContext context) async {
    SignIn? data = await Auth_Api().Sign_Up_Api(context, name.text, email.text, pass.text, cPassword.text);

    if (data != null && data.success == true) {
      user = data;
      await Snak_Bar(context, "تم إنشاء الحساب بنجاح");

      notifyListeners();

      pushNewScreen(context, SignIn_Screen());

      return data.message;
    } else {
      await Snak_Bar(context, " تأكد من البيانات ");
      return null;
    }
  }
}
