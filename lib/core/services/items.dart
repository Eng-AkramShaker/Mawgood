import 'dart:convert';
import 'package:day12_login/core/services/api.dart';
import 'package:day12_login/model/items_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Class_Items extends Api {
// get_All_Categories_Api ============================================================================================

  Future<List<Product_model>> get_Items_Api(BuildContext context, String page) async {
    var headers = {'Authorization': 'Bearer 1|jysA5sXDClEISMbEw0QBtVnrkPdQd1DsUSt8LEz73fccbc49'};
    var request = http.Request('GET', Uri.parse('https://mawgood.x-crisis.com/public/api/categories/$page'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        ItemsModel itemsModel = ItemsModel.fromJson(jsonResponse);

        print(itemsModel.data.length);

        return itemsModel.data;
      } else {
        print('Error: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }
}
