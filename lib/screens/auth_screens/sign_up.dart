import 'package:animate_do/animate_do.dart';
import 'package:day12_login/controllers/auth/auth_provider.dart';
import 'package:day12_login/core/navigators.dart';
import 'package:day12_login/screens/auth_screens/sign_In.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingUp_Screen extends StatefulWidget {
  @override
  State<SingUp_Screen> createState() => _SingUp_ScreenState();
}

class _SingUp_ScreenState extends State<SingUp_Screen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth_Provider>(builder: (context, prov_auth, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 290,
                    decoration:
                        BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
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
                                    "Sing Up",
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
                      children: [
                        FadeInUp(
                            duration: Duration(milliseconds: 1800),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                                  boxShadow: [
                                    BoxShadow(color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.all(3),
                                    decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(143, 148, 251, 1)))),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none, hintText: "Name :", hintStyle: TextStyle(color: Colors.grey[700])),
                                      onChanged: (String value) {
                                        //

                                        setState(() {
                                          prov_auth.name.text = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.all(3),
                                    decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(143, 148, 251, 1)))),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email :",
                                          hintStyle: TextStyle(color: Colors.grey[700])),
                                      onChanged: (String value) {
                                        //

                                        setState(() {
                                          prov_auth.email.text = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.all(3),
                                    decoration:
                                        BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(143, 148, 251, 1)))),
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password :",
                                          hintStyle: TextStyle(color: Colors.grey[700])),
                                      onChanged: (String value) {
                                        //

                                        setState(() {
                                          prov_auth.pass.text = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.all(3),
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Confirm Password :",
                                          hintStyle: TextStyle(color: Colors.grey[700])),
                                      onChanged: (String value) {
                                        //

                                        setState(() {
                                          prov_auth.cPassword.text = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: InkWell(
                              onTap: () {
                                prov_auth.Sign_Up(context);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 15),
                        FadeInUp(
                          duration: Duration(milliseconds: 2000),
                          child: InkWell(
                            onTap: () {
                              //
                              pushNewScreen(context, SignIn_Screen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "If you have an account  ",
                                  style: TextStyle(fontSize: 14, color: Color.fromRGBO(19, 20, 24, 1)),
                                ),
                                Text(
                                  "sign in",
                                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(70, 79, 255, 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 250)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
