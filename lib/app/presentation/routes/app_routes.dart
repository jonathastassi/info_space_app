import 'package:get/get.dart';
import 'package:info_space_app/app/presentation/pages/home/home_binding.dart';
import 'package:info_space_app/app/presentation/pages/home/home_page.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_binding.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_page.dart';

class AppRoutes {
  static final initialRoute = SplashPage.route;

  static final routes = [
    GetPage(
      name: SplashPage.route,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: HomePage.route,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
