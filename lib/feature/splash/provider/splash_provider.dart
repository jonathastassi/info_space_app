import 'package:flutter/material.dart';
import 'package:info_space_app/feature/splash/controller/splash_controller.dart';

class SplashProvider extends InheritedNotifier<SplashController> {
  SplashProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static SplashController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SplashProvider>()!
        .notifier!;
  }
}
