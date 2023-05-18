import 'package:get/get.dart';
import 'package:salebee/Screen/A_MenuPage/menupage_controller.dart';



class MenuPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>MenuPageController()
    );
  }
}
