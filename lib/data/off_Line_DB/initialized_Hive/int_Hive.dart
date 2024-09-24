// ignore_for_file: non_constant_identifier_names, avoid_print, file_names, unused_local_variable, await_only_futures

import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/off_Line_DB/hive_providers/hive_user.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Int_Hive() async {
  await Hive.initFlutter();
  await Hive.openBox<Map>('user');
}

// -------------------------------------------------------------------------------------------------

Fetch_All_Data_Hive({required context}) async {
  //
  final provLogin = Provider.of<Auth_Provider>(context, listen: false);
  final user_Hive = Provider.of<HiveUserProvider>(context, listen: false);

  //

  await user_Hive.getHiveUser();
}

// --------------------------------------------------------------------------------------------------------------

Delete_All_openBox_Hive({required context}) async {
  //
  final user_Hive = Provider.of<HiveUserProvider>(context, listen: false);

  await user_Hive.getHiveUser();
}
