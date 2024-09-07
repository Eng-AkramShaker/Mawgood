import 'package:animate_do/animate_do.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/screens/auth_screens/sign_In.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingUp_Screen extends StatefulWidget {
  @override
  State<SingUp_Screen> createState() => _SingUp_ScreenState();
}

class _SingUp_ScreenState extends State<SingUp_Screen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth_Provider>(builder: (context, prov_auth, child) {
      return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: wtColor,
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
                                      "إنشاء حساب جديد",
                                      style: TextStyle(color: wtColor, fontSize: 40, fontWeight: FontWeight.bold),
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
                                        height: 70,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "اسم المستخدم  :",
                                              hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor)),
                                          validator: prov_auth.validateUsername,
                                          onChanged: (String value) {
                                            //
                                            setState(() {
                                              prov_auth.name.text = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 70,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "البريد الإلكتروني :",
                                              hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor)),
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
                                        height: 70,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "الهاتف :",
                                              hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor)),
                                          onChanged: (String value) {
                                            //
                                            setState(() {
                                              prov_auth.phone.text = value;
                                            });
                                          },
                                        ),
                                      ),

                                      //
                                      Container(
                                        height: 70,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: primaryColor))),
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
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 70,
                                        padding: EdgeInsets.all(3),
                                        child: TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "تأكيد كلمة المرور :",
                                              hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor)),
                                          validator: prov_auth.validateConfirmPassword,
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
                                    prov_auth.Sign_up(context, _formKey);
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
                                        "إنشاء حساب جديد",
                                        style: TextStyle(fontSize: 16, color: wtColor, fontWeight: FontWeight.bold),
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
                                  pushNewScreen(context, SignIn_Screen());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "إذا كان لديك حساب بالفعل  ",
                                      style: TextStyle(fontSize: 14, color: bgColor),
                                    ),
                                    Text(
                                      "تسجيل الدخول",
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: bluColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 250)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
