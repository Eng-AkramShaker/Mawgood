import 'package:day12_login/data/model/sliders_model.dart';
import 'package:day12_login/data/services/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Sliders_Api extends Api {
  //
  // Fetch_Sliders_Api ===================================================================================

  Future<SlidersModel?> fetch_Sliders_Api(BuildContext context, String token) async {
    final headers = {'Authorization': 'Bearer $token'};
    final uri = Uri.parse('https://mawgood.x-crisis.com/public/api/sliders');

    final request = http.Request('GET', uri)..headers.addAll(headers);

    try {
      final http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        return SlidersModel.fromJson(jsonResponse);
      } else {
        print('Error: ${response.statusCode} ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
