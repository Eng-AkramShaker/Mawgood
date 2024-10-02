// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:day12_login/data/model/Search_Model.dart';
import 'package:day12_login/data/services/search_api.dart';
import 'package:flutter/material.dart';

class Search_Provider with ChangeNotifier {
  //

  bool is_loading = false;

  TextEditingController search_Text_controller = TextEditingController();

  TextEditingController updateSearchText = TextEditingController();

  // fetch items =====================================================================

  SearchModel? dataSearch;

  Future<void> fetch_Search(BuildContext context, String token, String value) async {
    is_loading = true;
    dataSearch = null;

    try {
      final fetchedData = await Search_Api().fetch_Search_Api(context, token, value);
      if (fetchedData != null) {
        dataSearch = fetchedData;
      } else {
        dataSearch = null;
      }
    } catch (error) {
      print("Error fetching search data: $error");
      dataSearch = null;
    } finally {
      is_loading = false;
      notifyListeners();
    }
  }
}
