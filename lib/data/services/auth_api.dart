// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/model/sign_in_model.dart';
import 'package:day12_login/screens/auth_screens/sign_In.dart';
import 'package:day12_login/screens/widgets/snack_bar/Snack_Bar.dart';
import 'package:day12_login/screens/widgets/snack_bar/select_menu.dart';
import 'package:day12_login/screens/widgets/text_field/text_filed.dart';
import 'package:day12_login/screens/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth_Api {
  //  mawgood-6
  // Sign In ===========================================================================================

  Future<SignIn?> SignIn_Api(BuildContext context, String email, String pass) async {
    var url = Uri.parse('https://mawgood.x-crisis.com/public/api/login');

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'email': email,
      'password': pass,

      // 'email': 'eng.akramsh@gmail.com',
      // 'password': '123456',
    });

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var json = jsonDecode(responseString);
        var signInResponse = SignIn.fromJson(json);
        return signInResponse;
      } else {
        print('Failed to sign in: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }

  // Sign Up ============================================================================================

  Future<SignIn?> Sign_Up_Api(BuildContext context, String name, String email, String password, String cPassword, String phone) async {
    var headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};

    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/register'));
    request.fields.addAll({'name': name, 'email': email, 'password': password, 'c_password': cPassword, 'phone': phone});

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var json = jsonDecode(responseString);
        var signInResponse = SignIn.fromJson(json);
        return signInResponse;
      } else {
        print('Failed to sign up: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }

  // Forget_Password_Api ============================================================================================

  Future Forget_Password_Api(BuildContext context, Auth_Provider pro_Auth, String email_forgetPass) async {
    // var headers = {'Authorization': 'Bearer ${pro_Auth.user!.data!.token}'};
    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/send_email'));
    request.fields.addAll({
      // 'email': 'eng.akramsh@gmail.com',

      'email': email_forgetPass,
    });

    try {
      // request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        await Snak_Bar(context, 'تم ارسال الكود الي البريد الإلكتروني ');

        TextEditingController email = TextEditingController();
        TextEditingController otp = TextEditingController();

        Snack_Select_Menu(
          context: context,
          widget: Container(
            height: 200,
            child: Column(
              children: [
                Custom_Text(text: '( OTP )  الكود', size: 20),
                SizedBox(height: 50),
                custom_Text_Field(hint_text: ' ( OTP )  الكود ', TEXT_controller: otp, color: w_grey_Color),
              ],
            ),
          ),
          onPressed: () async {
            //
            print(email_forgetPass);
            print(otp.text);

            pop(context);
            Check_OTP_Api(context, pro_Auth, email_forgetPass, otp.text);
          },
        );
      } else {
        Snak_Bar(context, ' تأكد من البريد الإلكتروني');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  // Check_OTP_Api ============================================================================================

  Future Check_OTP_Api(BuildContext context, Auth_Provider prov_auth, String email, String otp) async {
    TextEditingController otp_Controller = TextEditingController();
    TextEditingController pass_Controller = TextEditingController();
    TextEditingController c_pass_Controller = TextEditingController();

    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/check_token'));
    request.fields.addAll({
      'email': email,
      'token': otp,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await Snak_Bar(context, "تم التحقق بنجاح");

      Snack_Select_Menu(
        context: context,
        widget: Container(
          height: 300,
          child: Column(
            children: [
              Custom_Text(text: 'أدخل كلمه المرور الجديدة', size: 20),
              SizedBox(height: 50),
              Container(
                height: 70,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor))),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'كلمة المرور الجديدة',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor)),
                  validator: prov_auth.validatePassword,
                  onChanged: (String value) {
                    //

                    pass_Controller.text = value;
                  },
                ),
              ),
              Container(
                height: 70,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor))),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'تأكيد كلمة المرور',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor)),
                  validator: prov_auth.validatePassword,
                  onChanged: (String value) {
                    //

                    c_pass_Controller.text = value;
                  },
                ),
              ),
            ],
          ),
        ),
        onPressed: () async {
          //

          if (pass_Controller.text == c_pass_Controller.text) {
            await pop(context);

            await Create_New_Pass_Api(context, email, otp, pass_Controller.text, c_pass_Controller.text);
          } else {
            Snak_Bar(context, "كلمة المرور غير متطابقة");
          }
        },
      );
    } else {
      print(response.reasonPhrase);

      Snak_Bar(context, "الكود خطأ");
    }
  }

  // Forget_Password_Api ======================================================================================

  Future Create_New_Pass_Api(BuildContext context, String email, String otp, String pass, String c_pass) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/reset_password'));

    request.fields.addAll({
      'email': email,
      'token': otp,
      'password': pass,
      'c_password': c_pass,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await Snak_Bar(context, "تم تغير الباسورد بنجاح");

      pushNewScreen(context, SignIn_Screen());
    } else {
      print(response.reasonPhrase);

      Snak_Bar(context, "كلمة المرور  ضعيفة");
    }
  }

  // Delete Account   ======================================================================================

  Future<bool> delete_Account_Api(String token) async {
    final url = Uri.parse('https://mawgood.x-crisis.com/public/api/delete_account');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
