import 'package:day12_login/controllers/auth/auth_provider.dart';
import 'package:day12_login/controllers/home/home_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/screens/home/home.dart';
import 'package:day12_login/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

// aa@aa.com

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   Get.put<MyDrawerController>(MyDrawerController());

//   runApp(MultiProvider(providers: providers, child: MyApp()));
// }

// final List<SingleChildWidget> providers = [
//   ChangeNotifierProvider(create: (ctx) => Controller_Home()),
//   ChangeNotifierProvider(create: (ctx) => Auth_Provider()),
// ];

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ResponsiveSizer(builder: (context, orientation, screenType) {
// //       return ChangeNotifierProvider(
// //         create: (ctx) => Controller_Home(),
// //         child: MaterialApp(
// //           debugShowCheckedModeBanner: false,
// //           home: const SplashScreen(),
// //         ),
// //       );
// //     });
// //   }
// // }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Zoom Drawer Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends GetView<MyDrawerController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MyDrawerController>(
//       builder: (_) => ZoomDrawer(
//         controller: _.zoomDrawerController,
//         menuScreen: MenuScreen1(),
//         mainScreen: MainScreen2(),
//         borderRadius: 24.0,
//         showShadow: true,
//         angle: -12.0,
//         drawerShadowsBackgroundColor: Colors.grey,
//         slideWidth: MediaQuery.of(context).size.width * 0.65,
//       ),
//     );
//   }
// }

// class MenuScreen1 extends GetView<MyDrawerController> {
//   const MenuScreen1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.yellow,
//     );
//   }
// }

// class MainScreen2 extends GetView<MyDrawerController> {
//   const MainScreen2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveSizer(builder: (context, orientation, screenType) {
//       return ChangeNotifierProvider(
//         create: (ctx) => Controller_Home(),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: const SplashScreen(),
//         ),
//       );
//     });
//   }
// }

// class MyDrawerController extends GetxController {
//   final zoomDrawerController = ZoomDrawerController();

//   void toggleDrawer() {
//     print("Toggle drawer");
//     zoomDrawerController.toggle?.call();
//     update();
//   }
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<MyDrawerController>(MyDrawerController());

  runApp(MultiProvider(providers: providers, child: MyApp()));
}

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (ctx) => Controller_Home()),
  ChangeNotifierProvider(create: (ctx) => Auth_Provider()),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ChangeNotifierProvider(
          create: (ctx) => Controller_Home(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}

class MyHomePage extends GetView<MyDrawerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: w_grey_Color,
      body: GetBuilder<MyDrawerController>(
        builder: (_) => ZoomDrawer(
          controller: _.zoomDrawerController,
          menuScreen: MenuScreen1(),
          mainScreen: MainScreen2(),
          borderRadius: 24.0,
          showShadow: true,
          angle: -12.0,
          drawerShadowsBackgroundColor: Colors.grey,
          slideWidth: MediaQuery.of(context).size.width * 0.65,
        ),
      ),
    );
  }
}

class MenuScreen1 extends GetView<MyDrawerController> {
  const MenuScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<Auth_Provider, Controller_Home>(builder: (context, authProvider, home_Controller, child) {
      return SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            'https://cdn.al-ain.com/lg/images/2022/1/18/133-194702-smartest-person-iraqi-youth-competition_700x400.jpg'),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' 👋 مرحبااا.',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            authProvider.user?.data?.name ?? 'Ahmed Hassan',
                            style: TextStyle(fontSize: 15, color: primaryColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 20.0),
                  ListTile(
                    leading: Icon(Icons.home, color: primaryColor),
                    title: Text('Home', style: TextStyle(color: primaryColor)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: primaryColor),
                    title: Text('Profile', style: TextStyle(color: primaryColor)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: primaryColor),
                    title: Text('Logout', style: TextStyle(color: primaryColor)),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class MainScreen2 extends StatelessWidget {
  const MainScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Home_Screen();
  }
}

// class MainScaffold extends GetView<MyDrawerController> {
//   final Widget body;
//   const MainScaffold({Key? key, required this.body}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       appBar: AppBar(
//         // backgroundColor: primaryColor,
//         leading: IconButton(
//           icon: Icon(Icons.menu),
//           onPressed: controller.toggleDrawer,
//         ),
//         title: Text('Main Screen'),
//       ),
//       body: body,
//     );
//   }
// }

class MyDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    update();
  }
}
