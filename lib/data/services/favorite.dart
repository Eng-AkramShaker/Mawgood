import 'dart:convert';

import 'package:day12_login/data/model/favorites_model.dart';
 import 'package:day12_login/screens/widgets/snack_bar/Snack_Bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class class_Favorite_api   {
  //
// Add Favorite ============================================================================================

  Future<FavoritesModel> Add_Favorite_api(BuildContext context, String token, String id) async {
    final headers = {'Authorization': 'Bearer $token'};
    final request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/favorites'))
      ..fields['place_id'] = id
      ..headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final favoritesModel = FavoritesModel.fromJson(jsonDecode(responseBody));

      if (favoritesModel.message == 'Favorite created successfully.') {
        Snak_Bar(context, 'تم إضافتها إلى المفضلة');
      } else if (favoritesModel.message == 'Favorite deleted successfully.') {
        Snak_Bar(context, 'تم إزالتها إلى المفضلة');
      }
      print(favoritesModel.message);
      return favoritesModel;
    } else {
      print('Error: ${response.reasonPhrase}');

      throw Exception('Failed to add favorite');
    }
  }

  // Delete Favorite =======================================================================================

  Future<FavoritesModel?> Delete_Favorite_api(BuildContext context, String token, String id) async {
    final headers = {'Authorization': 'Bearer $token'};

    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/favorites'));
    request.fields.addAll({'place_id': id});

    try {
      request.headers.addAll(headers);
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final favoritesModel = FavoritesModel.fromJson(jsonDecode(responseBody));
        Snak_Bar(context, 'تم حذفها من المفضلة');

        print(favoritesModel.message);
        return favoritesModel;
      } else {
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
