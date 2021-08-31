import 'package:flutter/material.dart';
import 'package:info_space_app/app/app.dart';
import 'package:info_space_app/core/dependency_injection/dependency_injection_config.dart';

void main() {
  setupLocator();
  runApp(App());
}
