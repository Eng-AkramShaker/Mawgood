import 'package:animate_do/animate_do.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/model/sign_in_model.dart';
import 'package:day12_login/data/services/auth_api.dart';
import 'package:day12_login/main.dart';
import 'package:day12_login/screens/auth_screens/forgot_password.dart';
import 'package:day12_login/screens/auth_screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn_Screen extends StatefulWidget {
  const SignIn_Screen({super.key});

  @override
  State<SignIn_Screen> createState() => _SignIn_ScreenState();
}

class _SignIn_ScreenState extends State<SignIn_Screen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer3<Auth_Provider, Profile_Provider, Favorite_Controller>(
        builder: (context, prov_auth, pro_Profile, pro_Favorite, child) {
      return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(
                              duration: Duration(seconds: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/light-1.png'),
                                  ),
                                ),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: Container(
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1300),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/clock.png'),
                                  ),
                                ),
                              )),
                        ),
                        Positioned(
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "تسجيل الدخول",
                                    style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          FadeInUp(
                              duration: Duration(milliseconds: 1800),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: wtColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: primaryColor),
                                    boxShadow: [BoxShadow(color: secondaryColor, blurRadius: 20.0, offset: Offset(0, 10))]),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor))),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "البريد الإلكتروني :",
                                          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor),
                                        ),
                                        validator: prov_auth.validateEmail,
                                        onChanged: (String value) {
                                          //

                                          setState(() {
                                            prov_auth.email.text = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: TextFormField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "كلمة المرور :",
                                            hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor)),
                                        validator: prov_auth.validatePassword,
                                        onChanged: (String value) {
                                          //

                                          setState(() {
                                            prov_auth.pass.text = value;
                                            print('pressed');
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          FadeInUp(
                              duration: Duration(milliseconds: 1900),
                              child: InkWell(
                                onTap: () async {
                                  await prov_auth.Sign_In(context, _formKey, prov_auth, pro_Favorite, pro_Profile);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        primaryColor,
                                        primaryColor,
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "تسجيل الدخول",
                                      style: TextStyle(color: wtColor, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20),
                          FadeInUp(
                            duration: Duration(milliseconds: 2000),
                            child: InkWell(
                              onTap: () {
                                //
                                pushNewScreen(context, Forgot_Password_Screen());
                              },
                              child: Text(
                                "هل نسيت كلمة السر ؟",
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: bluColor),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FadeInUp(
                            duration: Duration(milliseconds: 2000),
                            child: InkWell(
                              onTap: () {
                                //
                                pushNewScreen(context, SingUp_Screen());
                              },
                              child: Text(
                                "إنشاء حساب جديد",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: bluColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // -----------------------------------------------------------

                  Row(
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: InkWell(
                          onTap: () async {
                            SignIn? data = await Auth_Api().SignIn_Api(context, 'akramaboubakersh@gmail.com', 'Aa12345678@');
                            if (data != null && data.success == true) {
                              setState(() {
                                prov_auth.user = data;
                                prov_auth.guest = 'akramaboubakersh@gmail.com';
                              });

                              await pro_Profile.fetch_Profile(context, prov_auth.user!.data!.token!);
                              pushAndRemoveUntil(context, MyHomePage());
                              print('skip');
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [primaryColor, w_grey_Color])),
                            child: Center(
                              child: Text(
                                "تخطي",
                                style: TextStyle(color: wtColor, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
