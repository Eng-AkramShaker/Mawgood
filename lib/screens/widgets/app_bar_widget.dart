// ignore_for_file: must_be_immutable

import 'package:day12_login/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AppBarWidget extends GetView<MyDrawerController> {
  String? name;
  AppBarWidget({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          // width: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/images/logo.png'),
        ),
        Center(
          child: InkWell(
            onTap: controller.toggleDrawer,
            child: Container(
              height: 30,
              // width: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/images/icon_drowar.png'),
            ),
          ),
        ),
      ],
    );
  }
}
