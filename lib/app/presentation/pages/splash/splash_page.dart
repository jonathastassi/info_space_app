import 'package:flutter/material.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_controller.dart';
import 'package:info_space_app/core/dependency_injection/dependency_injection_config.dart';

class SplashPage extends StatefulWidget {
  static String route = '/splash';

  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController splashController = locator<SplashController>();

  @override
  void initState() {
    splashController.goToHome();
    super.initState();
  }

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
