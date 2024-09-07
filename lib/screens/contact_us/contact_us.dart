// ignore_for_file: unused_field

import 'package:animate_do/animate_do.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/contact_us/contact_us.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contact_Us_Screen extends StatefulWidget {
  const Contact_Us_Screen({super.key});

  @override
  State<Contact_Us_Screen> createState() => _Contact_Us_ScreenState();
}

class _Contact_Us_ScreenState extends State<Contact_Us_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _autoValidate = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer4<Auth_Provider, Profile_Provider, Favorite_Controller, Contact_us_Controller>(
      builder: (context, provAuth, proProfile, proFavorite, proContact_us, child) {
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
                            "تواصل معنا ....",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                                border: Border.all(color: primaryColor),
                                boxShadow: [
                                  BoxShadow(color: secondaryColor, blurRadius: 20.0, offset: Offset(0, 10)),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildTextField(
                                    controller: nameController,
                                    hintText: "الأسم :",
                                  ),
                                  _buildTextField(
                                    controller: emailController,
                                    hintText: "الأيميل :",
                                    // validator: validateStudentEmailAddress,
                                  ),
                                  _buildTextField(
                                    controller: phoneNumberController,
                                    hintText: "رقم الهاتف :",
                                    // validator: validateStudentPhoneNumber,
                                  ),
                                  _buildTextField(
                                    controller: subjectController,
                                    hintText: "عنوان الموضوع :",
                                  ),
                                  Container(
                                    height: 120,
                                    width: double.infinity,
                                    child: _buildTextField(
                                      controller: messageController,
                                      hintText: "الرسالة :",
                                      minLines: 3,
                                      maxLines: 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: InkWell(
                              onTap: () async {
                                await proContact_us.Send_Contact_us(
                                  context,
                                  provAuth.user!.data!.token!,
                                  nameController.text,
                                  emailController.text,
                                  phoneNumberController.text,
                                  subjectController.text,
                                  messageController.text,
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [primaryColor, primaryColor],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "إرسال",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    int minLines = 1,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: primaryColor)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: gryColor),
        ),
        minLines: minLines,
        maxLines: maxLines,
        onChanged: (String value) {
          setState(() {
            // Update corresponding provider value
          });
        },
      ),
    );
  }
}
