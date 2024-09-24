// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/off_Line_DB/hive_providers/hive_user.dart';
import 'package:day12_login/main.dart';
import 'package:day12_login/data/model/sign_in_model.dart';
import 'package:day12_login/screens/auth_screens/sign_In.dart';
import 'package:day12_login/screens/widgets/snack_bar/Snack_Bar.dart';
import 'package:day12_login/data/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth_Provider with ChangeNotifier {
  //
  String guest = '';

  SignIn? user;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController phone = TextEditingController();

  // forget Password ====================================

  TextEditingController OTP = TextEditingController();
  TextEditingController Email_forgetPass = TextEditingController();

//  IF <8> / A Z $#@ ===================================================================================================

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    if (!RegExp(r'^[a-zA-Z0-9.@]+$').hasMatch(value)) {
      return 'يجب أن يكون البريد الإلكتروني باللغة الإنجليزية فقط';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'تنسيق البريد الإلكتروني غير صالح';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length <= 5) {
      return ' يجب أن تكون كلمة المرور أكثر من 6 أحرف';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value != pass.text) {
      return 'كلمات المرور غير متطابقة';
    }
    return null;
  }

  //  Sign In  ============================================

  Future<String?> Sign_In(BuildContext context, GlobalKey<FormState> formKey, Auth_Provider prov_auth,
      Favorite_Controller pro_Favorite, Profile_Provider pro_Profile) async {
    final pro_hive_User = Provider.of<HiveUserProvider>(context, listen: false);
    await pro_hive_User.getHiveUser();

    //

    if (formKey.currentState != null && formKey.currentState!.validate()) {
      SignIn? data = await Auth_Api().SignIn_Api(context, email.text, pass.text);

      if (data != null && data.success == true) {
        user = data;

        // Hive -------------------------------------

        if (pro_hive_User.hiveUser == null) {
          pro_hive_User.addHiveUser(user: user!);
        }

        // ------------------------------------------

        Snak_Bar(context, 'تم تسجيل الدخول بنجاح');
        notifyListeners();

        await pro_Profile.fetch_Profile(context, user!.data!.token!);
        pushAndRemoveUntil(context, MyHomePage());

        return data.message;
      } else {
        await Snak_Bar(context, "التحقق من الايميل او كلمة المرور");
        return null;
      }
    }
    return null;
  }

  //  Sign Up  ============================================

  Sign_up(context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      SignIn? data = await Auth_Api().Sign_Up_Api(context, name.text, email.text, pass.text, cPassword.text, phone.text);

      if (data != null && data.success == true) {
        user = data;
        await Snak_Bar(context, "تم إنشاء الحساب بنجاح");

        notifyListeners();

        pushNewScreen(context, SignIn_Screen());

        return data.message;
      } else {
        await Snak_Bar(context, "الحساب مسجل بالفعل");
        return null;
      }
    } else {
      await Snak_Bar(context, "حاول مرة أخرى لتسجيل حساب جديد");
    }
  }

  //  Forget_password  ============================================

  Future Forget_password(BuildContext context, Auth_Provider pro_Auth) async {
    await Auth_Api().Forget_Password_Api(context, pro_Auth, Email_forgetPass.text);
  }

  // Delete Account   ======================================================================================

  Future Delete_Account(BuildContext context, String token) async {
    await Auth_Api().delete_Account_Api(token).then((value) {
      if (value == true) {
        Snak_Bar(context, 'تم حذف الحساب بنجاح');

        pushAndRemoveUntil(context, SignIn_Screen());
      } else {
        Snak_Bar(context, "تأكد انك متصل بالأنترنت");
      }
    });
  }
}
