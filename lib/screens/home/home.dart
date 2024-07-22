// ignore_for_file: avoid_print, unused_field, sized_box_for_whitespace, camel_case_types, must_be_immutable, non_constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_local_variable, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:day12_login/controllers/home/home_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/screens/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:provider/provider.dart';
import 'home_body.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home_Screen> with TickerProviderStateMixin {
  TabController? _tabController;
  Controller_Home crlHome = Controller_Home();

  @override
  void initState() {
    super.initState();
    ints(context);
    crlHome.motionTabBarController = MotionTabBarController(initialIndex: 3, length: 4, vsync: this);
  }

  ints(context) async {
    crlHome = Provider.of<Controller_Home>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    crlHome.motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        controller: crlHome.motionTabBarController,
        initialSelectedTab: "الرئيسية",
        useSafeArea: true,
        labels: const ["تواصل معنا", "المفضلة", "حسابي", "الرئيسية"],
        icons: const [Icons.settings, Icons.favorite_border, Icons.person, Icons.home],
        badges: [
          // MotionBadgeWidget(
          //   text: 'AAAAA',
          //   textColor: Colors.white, // optional, default to Colors.white
          //   color: Colors.red, // optional, default to Colors.red
          //   size: 20, // optional, default to 18
          // ),
          null,
          null,
          null,
          null,
        ],
        tabSize: 50,
        tabBarHeight: 60,
        textStyle: TextStyle(fontSize: 12, color: wtColor, fontWeight: FontWeight.w500),
        tabIconColor: wtColor,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: wtColor,
        tabIconSelectedColor: primaryColor,
        tabBarColor: primaryColor,
        onTabItemSelected: (int value) {
          setState(() {
            crlHome.motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: crlHome.motionTabBarController,
        children: [
          Empty_Screen(),
          Empty_Screen(),
          Empty_Screen(),
          Home_body_Screen(),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
