import 'package:flutter/material.dart';

import 'home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController() : super(HomeState.peoplesInSpace);

  void changeTab(int index) {
    switch (index) {
      case 0:
        value = HomeState.peoplesInSpace;
        break;
      case 1:
        value = HomeState.seeIssLocation;
        break;
      default:
        value = HomeState.peoplesInSpace;
    }
  }
}
