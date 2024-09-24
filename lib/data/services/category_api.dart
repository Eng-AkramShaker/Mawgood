import 'dart:convert';
import 'package:day12_login/data/model/all_category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Class_AllCategories {
// get_All_Categories_Api ============================================================================================

  Future<List<Datum>> get_All_Categories_Api(BuildContext context, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.Request('GET', Uri.parse('https://mawgood.x-crisis.com/public/api/categories'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();

        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        AllCategories allCategories = AllCategories.fromJson(jsonResponse);

        return allCategories.data;
      } else {
        print('Error: ${response.reasonPhrase}');
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load categories');
    }
  }
}
