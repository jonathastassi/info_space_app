import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_space_app/app/presentation/dependency_injection/dependency_injection_config.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_page.dart';
import 'package:info_space_app/app/presentation/routes/app_routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Info Space',
      initialBinding: DependencyInjectionConfig(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      getPages: AppRoutes.routes,
      initialRoute: SplashPage.route,
    );
  }
}
