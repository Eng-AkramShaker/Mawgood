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




