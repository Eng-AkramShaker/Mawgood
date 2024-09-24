import 'package:animate_do/animate_do.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Forgot_Password_Screen extends StatefulWidget {
  const Forgot_Password_Screen({super.key});

  @override
  State<Forgot_Password_Screen> createState() => _SignIn_ScreenState();
}

class _SignIn_ScreenState extends State<Forgot_Password_Screen> {
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
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
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
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
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
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "نسيت كلمة السر",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
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
                                  boxShadow: [
                                    BoxShadow(
                                        color: secondaryColor,
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Container(
                                height: 60,
                                padding: EdgeInsets.all(5),
                                child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "  أدخل الايميل  الخاص بك ..... ",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: gryColor)),
                                  onChanged: (String value) async {
                                    //
                                    setState(() {
                                      prov_auth.Email_forgetPass.text = value;
                                    });
                                  },
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            //

                            await prov_auth.Forget_password(context, prov_auth);
                          },
                          child: FadeInUp(
                            duration: Duration(milliseconds: 1900),
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
                                  "إرسال كود التفعيل",
                                  style: TextStyle(
                                      color: wtColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
