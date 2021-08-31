import 'package:flutter/material.dart';
import 'package:info_space_app/app/presentation/pages/home/home_page.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_page.dart';

class RoutesConfig {
  final String initialRoute = SplashPage.route;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Map<String, WidgetBuilder> get routes => {
        SplashPage.route: (_) => SplashPage(),
        HomePage.route: (_) => HomePage(),
      };
}
