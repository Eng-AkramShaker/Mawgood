// ignore_for_file: deprecated_member_use

import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/screens/favorite/favorite.dart';
import 'package:day12_login/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'home_body.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home_Screen> with TickerProviderStateMixin {
  // ignore: unused_field
  TabController? _tabController;
  Controller_Home crlHome = Controller_Home();

  @override
  void initState() {
    super.initState();
    ints(context);
    crlHome.motionTabBarController = MotionTabBarController(initialIndex: 2, length: 3, vsync: this);
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
    return WillPopScope(
      onWillPop: () async {
        if (crlHome.motionTabBarController!.index != 2) {
          // إذا لم يكن المستخدم على صفحة "الرئيسية"، انتقل إلى الصفحة "الرئيسية"
          setState(() {
            crlHome.motionTabBarController!.index = 2;
          });
          return false; // منع التطبيق من الخروج
        }
        return true; // السماح بالخروج إذا كان المستخدم على الصفحة "الرئيسية"
      },
      child: Scaffold(
        bottomNavigationBar: MotionTabBar(
          controller: crlHome.motionTabBarController,
          initialSelectedTab: "الرئيسية",
          useSafeArea: true,
          labels: const ["حسابي", "المفضلة", "الرئيسية"],
          icons: const [Icons.person, Icons.favorite_border, Icons.home],
          tabSize: 50,
          tabBarHeight: 60,
          textStyle: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          tabIconColor: Colors.white,
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: Colors.white,
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
            ProfileScreen(),
            Favorite_Screen(),
            Home_body_Screen(),
          ],
        ),
      ),
    );
  }
}
