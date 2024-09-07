// ignore_for_file: unused_local_variable

import 'package:day12_login/data/model/get_paces_model.dart';
import 'package:day12_login/data/model/one_Item_model.dart';
import 'package:day12_login/data/services/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Places_Api extends Api {
  //
// Fetch_All Places _Api ============================================================================================

  Future<GetPlacesModel?> Get_Places_Api(BuildContext context, String token, String id) async {
    print(id);

    final headers = {'Authorization': 'Bearer $token', 'Cookie': 'XSRF-TOKEN=...; mawgood_session=...'};

    final request = http.Request('GET', Uri.parse('https://mawgood.x-crisis.com/public/api/places/$id/the_places'));
    request.headers.addAll(headers);

    try {
      final http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseBody) as Map<String, dynamic>;
        return GetPlacesModel.fromJson(jsonData);
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    }

    return null;
  }

  // Fetch_one item_Api ============================================================================================

  Future<OneItemModel?> Get_one_Item_Api(BuildContext context, String token, String index_id, String show_id) async {
    print('$index_id ' + '$show_id');
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6Ii9QcnE3M29Bb3J6SVYvSHk3QzhsTVE9PSIsInZhbHVlIjoiL1BkbDZhdkdzcmk2R2YxYndzZ0huVmdTNjdOR0RQK0g5QWJ1czErazg0cDBnbVhkaktQcWduV3dtR0xrRUU2MzNpeWNQMElxbTBTOC96bkE0Y3R5QTVlMjdNK3lha3NwZHhMc1lJVzdxUk5pdm56VlNtM2doUk4zbUFnUEJ2ODAiLCJtYWMiOiIwMjUwYjg0MzM4YzIxN2Y0MDM2NTNkZjEwNTM2ODllYjNhYjNlOWFlMDI5MmZkMDYxM2ExMDdhNDA2Mjc4OTA3IiwidGFnIjoiIn0%3D; mawgood_session=eyJpdiI6IkplTVRBSXExZUwwQ0VEL0R4cFY2QXc9PSIsInZhbHVlIjoiR1Q4NldMVGJuTEdQbUY4WEpWMnpGZFo1UEYxRmNvdlNTKzBiNFZZai8wUFFuSlFyYWJaNUtzcHhlWnNJTmNndGREck4yQm9sa2FUcmEraHZXOU9vbFAvWXFwSG1HV1FURmZKQStNb2JSTjRZOW5YaUZrU01iTDY2SG5YeFdCbzkiLCJtYWMiOiI1NzVjOTgxMDE4M2Y1Mzg1MWIwMTE5M2Y4ZDA0ODM1MjZhMzU2NDEzNTI2NTZkZWM4NjZmZmJkYTQwOTM5ZThlIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request('GET', Uri.parse('https://mawgood.x-crisis.com/public/api/places/$index_id/the_places/$show_id'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseBody);
        OneItemModel item = OneItemModel.fromJson(jsonData);

        print(item.data!.address.toString());

        return item;
      } else {
        print('Error:  OneItemModel');
      }
    } catch (e) {
      print('Exception: OneItemModel ==========');
    }

    return null;
  }
}
