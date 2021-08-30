import 'package:get/get.dart';
import 'package:info_space_app/app/presentation/pages/home/home_page.dart';

class SplashController extends GetxController {
  Future<void> goToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offAllNamed(HomePage.route);
  }

  @override
  void onInit() {
    goToHome();
    super.onInit();
  }
}
