import 'package:flutter/material.dart';
import 'package:info_space_app/app/app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(App());
}
