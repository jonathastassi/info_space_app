import 'package:get/get.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
