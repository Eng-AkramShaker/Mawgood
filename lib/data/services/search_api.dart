import 'package:day12_login/data/model/Search_Model.dart';
import 'package:day12_login/data/services/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Search_Api extends Api {
  //
  // Fetch_Sliders_Api ===================================================================================

  Future<SearchModel?> fetch_Search_Api(BuildContext context, String token, String name) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IkZFNGsrSHZBMS9SYythQ2lYZ2NXclE9PSIsInZhbHVlIjoiay9Fb1g2bG9ZcGNNT1dLK3ZSRXd4R3hYbzk0by9kRVRMK2dSL2JIYThXK1VER2ZwNUJoTXJ3SDh0Wm5vQTRJVmlnUnNpSmRCWnJHdUJURFBESEFVZWIycnJzVkZTWXFObVR5NU0xSDZ6VmovSkN2dVUvK3VTWGIra3JOQXkxSVQiLCJtYWMiOiJiMDg3ZmY0YjcyN2IwMTFkMDY4MDk4MTllMjNiMTMyZDBlMGM5ZGQ0YWRjMjdiMjFiOWI3YzFjZTg0MTQzYTQ2IiwidGFnIjoiIn0%3D; mawgood_session=eyJpdiI6InBNb28xWmI2RkpxZTBlcjg1OFBRTGc9PSIsInZhbHVlIjoiTVRaQ21Dd2hlemE2ZnRTU3MzZEl3ZzlBMVh4SDJZbkVRRUwxeGpMb1IzZUUyQzhlZ2IvWklMR0NvMTczSXlMQ3g4L3lRbm5YanZERlN0Q1lNM2FMTXh4WnBwK2svZDJzajNsNExXSmxyTDljNHBiMS90RldFeElFQjRFbWlYQlIiLCJtYWMiOiI0NzkxZjFmNzcxMmU2ZTc5NzY5Y2MzNzE1MTY0MmVhNjNmZmNjNDAxNjJlNmY3YTc1YTgxM2RlYWMwNDFkZTE3IiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/search'));
    request.fields.addAll({'name': name});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      final searchModel = SearchModel.fromJson(jsonResponse);
      print(searchModel);
      return searchModel;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
}
