import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  static String route = '/splash';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'info SPACE',
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
