// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, camel_case_types, unused_element, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MyDrawerController extends ChangeNotifier {
  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    notifyListeners();
    // Notify listeners to update the UI if needed
  }
}
