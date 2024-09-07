import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/data/off_Line_DB/hive_providers/hive_user.dart';
import 'package:day12_login/main.dart';
import 'package:day12_login/screens/auth_screens/sign_In.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    intS();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Animation duration (2 seconds)
    );

    // Define the slide-in animation
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0), // Slide from left
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Define the fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start animations after a delay
    Future.delayed(Duration(seconds: 2), () {
      _controller.forward();
    });

    // Navigate to login screen after animations complete
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // pushNewScreen(context, SignIn_Screen());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  intS() async {
    final pro_hive_User = Provider.of<HiveUserProvider>(context, listen: false);
    final pro_Profile = Provider.of<Profile_Provider>(context, listen: false);
    final pro_Favorite = Provider.of<Favorite_Controller>(context, listen: false);
    final pro_Auth = Provider.of<Auth_Provider>(context, listen: false);

    try {
      await pro_hive_User.getHiveUser();

      if (pro_hive_User.hiveUser != null && pro_hive_User.hiveUser!.data != null && pro_hive_User.hiveUser!.data!.token != null) {
        await pro_Profile.fetch_Profile(context, pro_Favorite, pro_hive_User.hiveUser!.data!.token!);

        setState(() {
          pro_Auth.user = pro_hive_User.hiveUser;
        });

        pushAndRemoveUntil(context, MyHomePage());
      } else {
        print('User data or token is null');
        pushAndRemoveUntil(context, SignIn_Screen());
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
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
                            image: AssetImage(
                              "assets/images/logo.png",
                            ),
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
      ),
    );
  }
}
