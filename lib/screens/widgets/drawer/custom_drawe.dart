import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/core/constants/navigators.dart';
import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/drawer/drawer.dart';
import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/data/off_Line_DB/hive_providers/hive_user.dart';
import 'package:day12_login/screens/about/about.dart';
import 'package:day12_login/screens/auth_screens/sign_In.dart';
import 'package:day12_login/screens/auth_screens/sign_up.dart';
import 'package:day12_login/screens/contact_us/contact_us.dart';
import 'package:day12_login/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Custom_Drawer extends StatefulWidget {
  const Custom_Drawer({super.key});

  @override
  State<Custom_Drawer> createState() => _Custom_DrawerState();
}

class _Custom_DrawerState extends State<Custom_Drawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width / 2,
      child: Consumer3<Auth_Provider, Controller_Home, MyDrawerController>(
          builder: (context, authProvider, homeController, drawerController, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Material(
                color: primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage('https://sisd.gujaratuniversity.ac.in/assets/images/student.jpg'),
                        ),
                        SizedBox(height: 12),
                        Text('  👋 مرحبااا. ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('${authProvider.user!.data!.name}', style: TextStyle(fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home, color: primaryColor),
                    title: Text('الرئيسية', style: TextStyle(color: primaryColor)),
                    onTap: () {
                      drawerController.toggleDrawer();
                      homeController.motionTabBarController!.index = 2;
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: primaryColor),
                    title: Text('حسابي', style: TextStyle(color: primaryColor)),
                    onTap: () {
                      setState(() {
                        drawerController.toggleDrawer();
                        homeController.motionTabBarController!.index = 0;
                      });
                      // pushAndRemoveUntil(context, MyHomePage());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_mail, color: primaryColor),
                    title: Text('تواصل معنا', style: TextStyle(color: primaryColor)),
                    onTap: () {
                      //

                      pushNewScreen(context, Contact_Us_Screen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info, color: primaryColor),
                    title: Text('من نحن', style: TextStyle(color: primaryColor)),
                    onTap: () {
                      //

                      pushNewScreen(context, About_Screen());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip, color: primaryColor),
                    title: Text('سياسة الخصوصية ', style: TextStyle(color: primaryColor)),
                    onTap: () {
                      //

                      pushNewScreen(context, Privacy_Policy_Screen());
                    },
                  ),
                  authProvider.guest == 'eng.akramsh@gmail.com'
                      ? ListTile(
                          leading: Icon(Icons.logout, color: greenColor),
                          title: Text('انشاء حساب', style: TextStyle(color: greenColor, fontWeight: FontWeight.bold)),
                          onTap: () {
                            setState(() {
                              authProvider.guest = '';
                            });
                            pushAndRemoveUntil(context, SingUp_Screen());

                            print(authProvider.guest);
                          },
                        )
                      : ListTile(
                          leading: Icon(Icons.logout, color: redColor),
                          title: Text('تسجيل الخروج', style: TextStyle(color: redColor, fontWeight: FontWeight.bold)),
                          onTap: () async {
                            final pro_hive_User = Provider.of<HiveUserProvider>(context, listen: false);

                            await pro_hive_User.deleteUser();

                            pushAndRemoveUntil(context, SignIn_Screen());

                            print(authProvider.guest);
                          },
                        ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
