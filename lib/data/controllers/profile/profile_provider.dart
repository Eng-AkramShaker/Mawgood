// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'dart:io';

import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/services/profile_api.dart';
import 'package:day12_login/data/model/get_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile_Provider with ChangeNotifier {
  //

  GetProfileModel? data_Profile;

  List<Favorite> List_Favorite = [];
  bool is_loading = false;

//
  List<File> images_File = [];

  var gender;
  String? selectedDate;
  final TextEditingController password = TextEditingController();
  final TextEditingController c_password = TextEditingController();

  //  fetch items =============================================================================================

  Future<void> fetch_Profile(BuildContext context, Favorite_Controller pro_Favorite, String token) async {
    is_loading = true;
    List_Favorite = [];

    try {
      final response = await Profile_Api().Fetch_Profile_Api(context, token);
      if (response != null && response.data != null) {
        List_Favorite = response.data!.favorites;
        data_Profile = response;
      } else {
        data_Profile = GetProfileModel(
          success: false,
          data: Data(id: 0, name: '', profile: null, favorites: [], subscriptions: []),
          message: 'No data available',
        );
      }
    } catch (error) {
      data_Profile = GetProfileModel(
        success: false,
        data: Data(id: 0, name: '', profile: null, favorites: [], subscriptions: []),
        message: 'Failed to fetch data',
      );
    } finally {
      is_loading = false;
      notifyListeners();
    }
  }

  //  Update_Profile ==========================================================================================

  Update_Profile(context, String token, String id, String gender, String date, String password, String c_password) async {
    //

    try {
      final response = await Profile_Api().Update_Profile_Api(context, token, id, gender, date, password, c_password);

      if (response != null && response.data != null) {
        List_Favorite = response.data!.favorites;
        data_Profile = response;
      } else {
        data_Profile = GetProfileModel(
          success: false,
          data: Data(id: 0, name: '', profile: null, favorites: [], subscriptions: []),
          message: 'No data available',
        );
      }
    } catch (error) {
      data_Profile = GetProfileModel(
        success: false,
        data: Data(id: 0, name: '', profile: null, favorites: [], subscriptions: []),
        message: 'Failed to fetch data',
      );
    } finally {
      notifyListeners();
    }
  }

  //  Select Date =====================================================================

  Future select_Date(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      if (isStartDate) {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      } else {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      }
      notifyListeners();
    }
  }
}
