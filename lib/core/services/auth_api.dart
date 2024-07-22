// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'package:day12_login/core/services/api.dart';
import 'package:day12_login/model/sign_in_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth_Api extends Api {
  //
  // Sign In ============================================================================================

  Future<SignIn?> SignIn_Api(BuildContext context, String email, String pass) async {
    var url = Uri.parse('https://mawgood.x-crisis.com/public/api/login');

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      // 'email': email,
      // 'password': pass,

      'email': 'aa@aa.com',
      'password': '123456',
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

  Future<SignIn?> Sign_Up_Api(BuildContext context, String name, String email, String password, String cPassword) async {
    var headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};

    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/register'));
    request.fields.addAll({'name': name, 'email': email, 'password': password, 'c_password': cPassword});

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
}
