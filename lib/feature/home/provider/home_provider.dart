import 'package:flutter/material.dart';
import 'package:info_space_app/feature/home/controller/home_controller.dart';

class HomeProvider extends InheritedNotifier<HomeController> {
  HomeProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static HomeController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HomeProvider>()!
        .notifier!;
  }
}
