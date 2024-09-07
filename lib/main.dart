import 'package:day12_login/data/controllers/auth/auth_provider.dart';
import 'package:day12_login/data/controllers/contact_us/contact_us.dart';
import 'package:day12_login/data/controllers/drawer/drawer.dart';
import 'package:day12_login/data/controllers/favorite/favorite.dart';
import 'package:day12_login/data/controllers/home/home_provider.dart';
import 'package:day12_login/data/controllers/places/Places.dart';
import 'package:day12_login/data/controllers/privacy_about/privacy_about.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/controllers/search/search_provider.dart';
import 'package:day12_login/data/off_Line_DB/hive_providers/hive_user.dart';
import 'package:day12_login/data/off_Line_DB/initialized_Hive/int_Hive.dart';
import 'package:day12_login/screens/home/home.dart';
import 'package:day12_login/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Main entry point

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Int_Hive();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => Controller_Home()),
      ChangeNotifierProvider(create: (ctx) => Auth_Provider()),
      ChangeNotifierProvider(create: (ctx) => MyDrawerController()),
      ChangeNotifierProvider(create: (ctx) => Profile_Provider()),
      ChangeNotifierProvider(create: (ctx) => Places_Controller()),
      ChangeNotifierProvider(create: (ctx) => Favorite_Controller()),
      ChangeNotifierProvider(create: (ctx) => Contact_us_Controller()),
      ChangeNotifierProvider(create: (ctx) => Privacy_About_Controller()),
      ChangeNotifierProvider(create: (ctx) => Search_Provider()),
      //
      ChangeNotifierProvider(create: (ctx) => HiveUserProvider()),
    ],
    child: MyApp(),
  ));
}

// MyApp Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}

// Main screen with ZoomDrawer
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer4<Auth_Provider, Controller_Home, MyDrawerController, Search_Provider>(
        builder: (context, authProvider, homeController, drawerController, pro_Search, child) {
      return Scaffold(
        backgroundColor: w_grey_Color,
        body: Home_Screen(),

        // Consumer<MyDrawerController>(
        //   builder: (context, drawerController, child) {
        //     return ZoomDrawer(
        //       controller: drawerController.zoomDrawerController,
        //       menuScreen: MenuScreen1(),
        //       mainScreen: Home_Screen(),
        //       borderRadius: 24.0,
        //       showShadow: true,
        //       angle: -12.0,
        //       drawerShadowsBackgroundColor: Colors.grey,
        //       slideWidth: MediaQuery.of(context).size.width * 0.65,
        //     );
        //   },
        // ),
      );
    });
  }
}

// Menu screen widget
// class MenuScreen1 extends StatefulWidget {
//   @override
//   State<MenuScreen1> createState() => _MenuScreen1State();
// }
// class _MenuScreen1State extends State<MenuScreen1> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer3<Auth_Provider, Controller_Home, MyDrawerController>(
//       builder: (context, authProvider, homeController, drawerController, child) {
//         return SafeArea(
//           child: Scaffold(
//             body: Container(
//               height: double.infinity,
//               width: double.infinity,
//               color: Colors.white,
//               padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 50.0,
//                           backgroundImage: NetworkImage(
//                             'https://sisd.gujaratuniversity.ac.in/assets/images/student.jpg',
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               authProvider.user?.data?.name ?? 'Ahmed',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: primaryColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               '  👋 مرحبااا. ',
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Divider(),
//                     SizedBox(height: 20.0),
//                     ListTile(
//                       leading: Icon(Icons.home, color: primaryColor),
//                       title: Text('الرئسية', style: TextStyle(color: primaryColor)),
//                       onTap: () {
//                         drawerController.toggleDrawer();
//                         homeController.motionTabBarController!.index = 2;
//                       },
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.person, color: primaryColor),
//                       title: Text('حسابي', style: TextStyle(color: primaryColor)),
//                       onTap: () {
//                         setState(() {
//                           drawerController.toggleDrawer();
//                           homeController.motionTabBarController!.index = 0;
//                         });
//                         // pushAndRemoveUntil(context, MyHomePage());
//                       },
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.contact_mail, color: primaryColor),
//                       title: Text('تواصل معنا', style: TextStyle(color: primaryColor)),
//                       onTap: () {
//                         //
//                         pushNewScreen(context, Contact_Us_Screen());
//                       },
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.info, color: primaryColor),
//                       title: Text('من نحن', style: TextStyle(color: primaryColor)),
//                       onTap: () {
//                         //
//                         pushNewScreen(context, About_Screen());
//                       },
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.privacy_tip, color: primaryColor),
//                       title: Text('سياسة الخصوصية ', style: TextStyle(color: primaryColor)),
//                       onTap: () {
//                         //
//                         pushNewScreen(context, Privacy_Policy_Screen());
//                       },
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.logout, color: redColor),
//                       title: Text('تسجيل الخروج', style: TextStyle(color: redColor, fontWeight: FontWeight.bold)),
//                       onTap: () {
//                         pushNewScreen(context, SignIn_Screen());
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



// ElevatedButton(
// onPressed: ()async {
// pro_Profile.fetch_Profile(context, pro_Auth.user!.data!.token!);
// },
// child: Text('data'),
// ),

// eng.akramsh@gmail.com

// Aa12345678@




// akramaboubakersh@gmail.com

// Aa12345678@

 


