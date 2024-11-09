import 'package:flutter/material.dart';
import 'package:info_space_app/feature/splash/controller/splash_state.dart';

class SplashController extends ValueNotifier<SplashState> {
  SplashController() : super(SplashState.loading);

  Future<void> init() async {
    value = SplashState.loading;
    await Future.delayed(const Duration(seconds: 2));
    value = SplashState.done;
  }
}
