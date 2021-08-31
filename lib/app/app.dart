import 'package:flutter/material.dart';
import 'package:info_space_app/core/dependency_injection/dependency_injection_config.dart';
import 'package:info_space_app/core/routes/routes_config.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Space',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: locator.get<RoutesConfig>().initialRoute,
      navigatorKey: locator.get<RoutesConfig>().navigatorKey,
      routes: locator.get<RoutesConfig>().routes,
    );
  }
}
