import 'package:day12_login/screens/widgets/snack_bar/Snack_Bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Rating_Api {
  //
  // Fetch_Sliders_Api ===================================================================================

  Future Send_Rating_Api(BuildContext context, String token, String place_id, String rating) async {
    final headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/reviews'));
    request.fields.addAll({'place_id': place_id, 'comment': 'comment', 'rating': rating});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      await Snak_Bar(context, 'تم أرسال التقييم بنجاح');
    } else {
      print("فشل التقييم");
    }
  }
}
