// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/screens/profile/widgets/gender_drop_down.dart';
import 'package:day12_login/screens/profile/widgets/siplay_image.dart';
import 'package:day12_login/screens/widgets/app_bar_widget.dart';
import 'package:day12_login/screens/widgets/drawer/custom_drawe.dart';
import 'package:day12_login/screens/widgets/snack_bar/select_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isloding = false;

  @override
  Widget build(BuildContext context) {
    return Consumer4<Auth_Provider, Controller_Home, Profile_Provider, Favorite_Controller>(
        builder: (context, pro_Auth, pro_home, pro_Profile, pro_Favorite, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(233, 235, 255, 1),
          appBar: AppBarWidget(context: context, show_Search: false),
          drawer: Custom_Drawer(),
          body: isloding
              ? Center(child: CircularProgressIndicator())
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            DisplayImage(
                              imagePath: "https://sisd.gujaratuniversity.ac.in/assets/images/student.jpg",
                              onPressed: () {},
                              images_File: pro_Profile.images_File,
                            ),
                            if (pro_Profile.data_Profile!.data!.profile != null)
                              Consumer<Profile_Provider>(builder: (context, proProfile, _) {
                                return Column(
                                  children: [
                                    pro_Auth.guest == 'eng.akramsh@gmail.com'
                                        ? buildUserInfoDisplay('Guest', 'الأسم')
                                        : buildUserInfoDisplay('${proProfile.data_Profile!.data!.name}', 'الأسم'),
                                    buildUserInfoDisplay(proProfile.data_Profile!.data!.profile!.gender!, 'النوع'),
                                    buildUserInfoDisplay('${proProfile.data_Profile!.data!.profile!.dateOfBirth}', 'تاريخ الميلاد'),
                                  ],
                                );
                              })
                            else
                              Column(
                                children: [
                                  pro_Auth.guest == 'eng.akramsh@gmail.com'
                                      ? buildUserInfoDisplay('Guest', 'الأسم')
                                      : buildUserInfoDisplay('Guest', 'الأسم'),
                                  buildUserInfoDisplay('ذكر', 'النوع'),
                                  buildUserInfoDisplay('2024-08-11', 'تاريخ الميلاد'),
                                ],
                              )
                          ],
                        ),
                        const SizedBox(height: 80),

                        //

                        pro_Auth.guest == 'akramaboubakersh@gmail.com'
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: FadeInUp(
                                  duration: Duration(milliseconds: 1900),
                                  child: InkWell(
                                    onTap: () async {
                                      //
                                      final val = pro_Profile.data_Profile!.data!.profile!.gender!;

                                      setState(() {
                                        if (val == 'female') {
                                          pro_Profile.gender = 'انثى';
                                        } else if (val == 'male') {
                                          pro_Profile.gender = 'ذكر';
                                        }
                                      });

                                      await Snack_Select_Menu(
                                        context: context,
                                        widget: SingleChildScrollView(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Container(
                                              height: 300,
                                              child: Column(
                                                children: [
                                                  FadeInUp(
                                                    duration: Duration(milliseconds: 1000),
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
                                                          GenderDropDown(),

                                                          //
                                                          InkWell(
                                                            onTap: () async {
                                                              await pro_Profile.select_Date(context, false);
                                                              pro_Profile.notifyListeners();
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              width: 300,
                                                              padding: EdgeInsets.all(5),
                                                              decoration: BoxDecoration(
                                                                border: Border(bottom: BorderSide(color: primaryColor)),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'تاريخ الميلاد :    ',
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
                                                                  Consumer<Profile_Provider>(
                                                                    builder: (context, pro_Profile, _) {
                                                                      return Text(
                                                                        pro_Profile.selectedDate != null
                                                                            ? pro_Profile.selectedDate!.toString()
                                                                            : 'yyyy-MM-dd',
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          _buildTextField(
                                                            controller: pro_Profile.password,
                                                            hintText: "الباسورد  :",
                                                          ),
                                                          _buildTextField(
                                                            controller: pro_Profile.c_password,
                                                            hintText: "تأكيد الباسورد :",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await pro_Profile.Update_Profile(
                                            context,
                                            pro_Auth.user!.data!.token!,
                                            pro_Profile.data_Profile!.data!.id.toString(),
                                            pro_Profile.gender,
                                            pro_Profile.selectedDate ?? '2000-09-10',
                                            pro_Profile.password.text,
                                            pro_Profile.c_password.text,
                                          );
                                          pop(context);

                                          setState(() {
                                            isloding = true;
                                          });
                                        },
                                      );
                                      print('===================================');

                                      await pro_Profile.fetch_Profile(context, pro_Favorite, pro_Auth.user!.data!.token!);
                                      pro_Profile.notifyListeners();

                                      setState(() {
                                        isloding = false;
                                      });

                                      print('===================================');

                                      print('${pro_Profile.data_Profile!.data!.profile!.dateOfBirth}');
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(colors: [primaryColor, primaryColor])),
                                      child: Center(
                                        child: Text("تعديل الحساب",
                                            style: TextStyle(color: wtColor, fontSize: 18, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }

  Widget buildUserInfoDisplay(String value, String title) {
    String getValue = value;

    if (value == 'female') {
      getValue = 'انثى';
    } else if (value == 'male') {
      getValue = 'ذكر';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: bluColor,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: gryColor,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: Center(
                  child: Text(
                    getValue,
                    style: TextStyle(color: gryColor, fontSize: 15, height: 1.4),
                  ),
                )),
                Icon(
                  Icons.keyboard_arrow_left,
                  color: bluColor,
                  size: 30.0,
                )
              ]))
        ],
      ),
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
      width: 300,
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
      ),
    );
  }
}
