import 'package:day12_login/screens/widgets/snack_bar/Snack_Bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Contact_us_Api {
  //
  // Fetch_Sliders_Api ===================================================================================

  Future Send_Contact_us_Api(
      BuildContext context, String token, String name, String email, String phone, String subject, String message) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse('https://mawgood.x-crisis.com/public/api/contact_us'));
    request.fields.addAll({
      'name': name,
      'email': email,
      'phone': phone,
      'subject': subject,
      'message': message,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Snak_Bar(context, "تم إرسال البيانات بنجاح");

      print(await response.stream.bytesToString());
    } else {
      Snak_Bar(context, "تأكد من المدخلات  ");
      print(response.reasonPhrase);
    }
  }
}
