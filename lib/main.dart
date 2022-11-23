import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/app_config.dart';
import 'package:movies/binding/app_binding.dart';
import 'package:movies/module/splash.dart';
import 'package:movies/utils/CustomRouter.dart';
import 'package:movies/utils/HexColor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Movies',
    onGenerateRoute: CustomRouter.generateRoute,
    routes: CustomRouter.getRoutes(),
    initialBinding: AppBinding(),
    theme: ThemeData(
        primarySwatch: HexColor.getMaterialColor(PRIMARY_COLOR_HEX),
        primaryColor: HexColor.getColor(PRIMARY_COLOR_HEX),
        primaryColorDark: HexColor.getColor(PRIMARY_DARK_COLOR_HEX),
        primaryColorLight: HexColor.getColor(PRIMARY_LIGHT_COLOR_HEX),
        textTheme: TextTheme(
          bodyText2: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          bodyText1: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16),
          caption: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.8), fontSize: 14),
          headline1: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 32),
          headline2: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 24),
          headline3: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Colors.white, fontSize: 14),
          headline4: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, color: Colors.white.withOpacity(.8), fontSize: 13),
          headline5: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, color: Colors.white.withOpacity(.8), fontSize: 12),
          headline6: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.8), fontSize: 10),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: HexColor.getColor(PRIMARY_ACCENT_COLOR_HEX)),
        fontFamily: 'Inter'),
    home: SplashScreen(),
  ));
}
