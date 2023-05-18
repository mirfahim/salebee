import 'package:get/get.dart';
import 'package:salebee/Screen/A_MenuPage/menupage_controller.dart';
import 'package:salebee/Screen/splashScreen/splash_controller.dart';



class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>SplashController()
    );
  }
}
