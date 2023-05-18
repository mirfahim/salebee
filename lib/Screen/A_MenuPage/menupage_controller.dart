import 'package:flutter/material.dart';
import 'package:get/get.dart';



class MenuPageController extends GetxController {
  //TODO: Implement BaseController
 final controllers = Get.find<GetxController>;
  final currentIndex = 1.obs;
  final categoryDataLoaded = false.obs;


  final appbarName = "".obs ;






  @override
  void onInit() {
    appbarName.value = "MenuPage";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

 void setLocale(Locale value) {

   //  local.value = value;

 }


}
