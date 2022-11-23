import 'package:flutter/material.dart';
import 'package:movies/module/base/base.dart';
import 'package:movies/module/splash.dart';
import 'package:movies/utils/CommonUtils.dart';

class CustomRouter {
  static getRoutes() {
    return <String, WidgetBuilder>{
      SplashScreen.routeName: (_) => SplashScreen(),
      Base.routeName: (_) => Base(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return getMaterialRoute(settings.name);
  }

  static MaterialPageRoute<dynamic> getMaterialRoute(String? routeName) {
    if (CommonUtils.checkIfNotNull(routeName)) {
      switch (routeName) {
        case SplashScreen.routeName:
          return MaterialPageRoute(builder: (_) => SplashScreen());
        case Base.routeName:
          return MaterialPageRoute(builder: (_) => Base());
        default:
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(child: Text('No route defined for ${routeName}')),
                  ));
      }
    } else {
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(child: Text('No route defined for ${routeName}')),
              ));
    }
  }
}
