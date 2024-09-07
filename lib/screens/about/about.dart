// ignore_for_file: unused_field, unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/contact_us/contact_us.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/privacy_about/privacy_about.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class About_Screen extends StatefulWidget {
  const About_Screen({super.key});

  @override
  State<About_Screen> createState() => _Contact_Us_ScreenState();
}

class _Contact_Us_ScreenState extends State<About_Screen> {
  final TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer5<Auth_Provider, Profile_Provider, Favorite_Controller, Contact_us_Controller, Privacy_About_Controller>(
      builder: (context, provAuth, proProfile, proFavorite, proContact_us, pro_Privacy_About, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: Text(
                            " من نحن ....",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Container(
                            // height: size.height / 2,
                            // width: size.width / .5,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primaryColor),
                              boxShadow: [
                                BoxShadow(color: secondaryColor, blurRadius: 20.0, offset: Offset(0, 10)),
                              ],
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(pro_Privacy_About.List_Privacy_About!.data!.aboutUs! ?? ''),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
