import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/data/off_Line_DB/hive_providers/hive_user.dart';
import 'package:day12_login/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/constants.dart';
import '../core/constants/navigators.dart';
import '../screens/auth_screens/sign_In.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1100));

    // Define animations
    _slideAnimation = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        _controller.forward();
      }
    });

    _controller.addStatusListener((status) async {
      final pro_hive_User = Provider.of<HiveUserProvider>(context, listen: false);
      final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);

      await pro_hive_User.getHiveUser();

      if (status == AnimationStatus.completed) {
        if (mounted) {
          // Hive -------------------------------------

          if (pro_hive_User.hiveUser != null) {
            setState(() {
              pro_Auth.user = pro_hive_User.hiveUser;
            });

            pushAndRemoveUntil(context, MyHomePage());
          } else {
            pushNewScreen(context, SignIn_Screen());
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      height: mediaheight(context) / 1.6,
                      width: mediawidth(context),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
