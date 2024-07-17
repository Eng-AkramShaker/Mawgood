import 'package:day12_login/controllers/auth/auth_provider.dart';
import 'package:day12_login/controllers/home/home_provider.dart';
import 'package:day12_login/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (ctx) => Home_Provider()),
  ChangeNotifierProvider(create: (ctx) => Auth_Provider()),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return ChangeNotifierProvider(
        create: (ctx) => Home_Provider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      );
    });
  }
}

// aa@aa.com