import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SplashController extends GetxController {
  //TODO: Implement BaseController

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




}
