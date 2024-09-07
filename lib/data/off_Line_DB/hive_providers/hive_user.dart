// ignore_for_file: unnecessary_cast

import 'package:day12_login/data/model/sign_in_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveUserProvider with ChangeNotifier {
  final Box<Map<dynamic, dynamic>> myBox = Hive.box<Map<dynamic, dynamic>>('user');

  SignIn? hiveUser;

  // ---------------------------------------------------------------------------------------

  Future<void> addHiveUser({required SignIn user}) async {
    final userMap = user.toJson();
    await myBox.put('user', userMap);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------------------

  Future<void> getHiveUser() async {
    try {
      final userMap = myBox.get('user') as Map<dynamic, dynamic>?;
      if (userMap != null) {
        hiveUser = SignIn.fromJson(userMap);
      } else {
        hiveUser = null;
      }
    } catch (e) {
      print('Error retrieving user from Hive: $e');
    }
  }
  // ---------------------------------------------------------------------------------------

  Future<void> deleteUser() async {
    await myBox.delete('user');
    hiveUser = null;
    notifyListeners();
  }
}
