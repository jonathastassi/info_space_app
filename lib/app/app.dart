import 'package:flutter/material.dart';
import 'package:info_space_app/app/theme/color_schemes.dart';
import 'package:info_space_app/feature/splash/view/splash_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Space',
      themeMode: ThemeMode.light,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const SplashPage(),
    );
  }
}
