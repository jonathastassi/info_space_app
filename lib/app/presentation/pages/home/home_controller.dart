import 'package:flutter/material.dart';

class HomeController {
  final tabIndex = ValueNotifier<int>(0);

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void dispose() {
    tabIndex.dispose();
  }
}
