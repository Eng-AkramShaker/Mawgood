import 'package:animate_do/animate_do.dart';
import 'package:day12_login/controllers/auth/auth_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/screens/auth_screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn_Screen extends StatefulWidget {
  const SignIn_Screen({super.key});

  @override
  State<SignIn_Screen> createState() => _SignIn_ScreenState();
}

class _SignIn_ScreenState extends State<SignIn_Screen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth_Provider>(builder: (context, prov_auth, child) {
      return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: Column(
                children: [
                  Container(
                    height: 280,
                    decoration:
                        BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill)),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(
                              duration: Duration(seconds: 1),
                              child: Container(
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/light-1.png'))),
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
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/clock.png'))),
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
                    child: Column(
                      children: <Widget>[
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
                                    height: 60,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor))),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "الأيميل :",
                                        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor),
                                      ),
                                      onChanged: (String value) {
                                        //

                                        setState(() {
                                          prov_auth.email.text = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    padding: EdgeInsets.all(5),
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "الباسورد :",
                                          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor)),
                                      onChanged: (String value) {
                                        //

                                        setState(() {
                                          prov_auth.pass.text = value;
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
                        InkWell(
                          onTap: () {
                            prov_auth.Sign_In(context);
                          },
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1900),
                              child: InkWell(
                                onTap: () {
                                  prov_auth.Sign_In(context);
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
                        ),
                        SizedBox(height: 20),
                        FadeInUp(
                            duration: Duration(milliseconds: 2000),
                            child: Text(
                              "هل نسيت كلمة السر ؟",
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: bluColor),
                            )),
                        SizedBox(height: 20),
                        FadeInUp(
                          duration: Duration(milliseconds: 2000),
                          child: InkWell(
                            onTap: () {
                              //
                              pushNewScreen(context, SingUp_Screen());
                            },
                            child: Text(
                              "أنشاء حساب جديد",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: bluColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
