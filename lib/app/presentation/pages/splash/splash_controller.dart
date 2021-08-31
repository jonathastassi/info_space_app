import 'package:info_space_app/app/presentation/pages/home/home_page.dart';
import 'package:info_space_app/core/routes/i_routes.dart';

class SplashController {
  final IRoutes routes;

  SplashController({required this.routes});

  Future<void> goToHome() async {
    await Future.delayed(Duration(seconds: 2));
    routes.pushReplacementNamed(HomePage.route);
  }
}
