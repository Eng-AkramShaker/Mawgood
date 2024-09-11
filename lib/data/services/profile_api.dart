import 'package:day12_login/data/services/api.dart';
import 'package:day12_login/data/model/get_profile_model.dart';
import 'package:day12_login/screens/widgets/snack_bar/Snack_Bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile_Api extends Api {
// Fetch_Profile_Api ============================================================================================

  Future<GetProfileModel?> Fetch_Profile_Api(BuildContext context, String token) async {
    print(' Fetch_Profile_Api     $token');

    final headers = {'Authorization': 'Bearer $token'};
    final url = Uri.parse('https://mawgood.x-crisis.com/public/api/user');
    final request = http.Request('GET', url);
    request.headers.addAll(headers);

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseBody);

        return GetProfileModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Update_Profile_Api ============================================================================================

  Future<GetProfileModel?> Update_Profile_Api(
      BuildContext context, String token, String id, String gender, String date, String password, String c_password) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/profile/$id?_method=PATCH'));

    request.fields.addAll({
      'gender': gender,
      'date_of_birth': date,
      'password': password,
      'c_password': password,
    });

    request.headers.addAll(headers);
    print('222222222===================================');

    http.StreamedResponse response = await request.send();
    print('222222222===================================');

    if (response.statusCode == 200) {
      Snak_Bar(context, "تم تعديل البيانات بنجاح");

      final responseBody = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseBody);

      return GetProfileModel.fromJson(jsonResponse);
    } else {
      // Snak_Bar(context, "لم يتم تعديل البيانات ");
      return null;
    }
  }
}
