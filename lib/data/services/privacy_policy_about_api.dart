import 'package:day12_login/data/model/privacy_policy_about_us_model.dart';
import 'package:day12_login/data/services/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Privacy_Policy_About_Api extends Api {
// Fetch_Profile_Api ============================================================================================

  Future<PrivacyPolicyAboutUsModel?> Get_Privacy_Policy_About_Api(BuildContext context, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(
      Uri.parse('https://mawgood.x-crisis.com/public/api/settings/1'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PrivacyPolicyAboutUsModel.fromJson(jsonResponse);
    } else {
      print('Failed to load data: ${response.reasonPhrase}');
      return null;
    }
  }
}
