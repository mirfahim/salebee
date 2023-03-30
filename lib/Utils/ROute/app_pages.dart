import 'package:get/get.dart';
import 'package:salebee/Screen/A_MenuPage/contact_book/contact_front_tab.dart';
import 'package:salebee/Screen/SplashScreen.dart';

import '../../Screen/A_MenuPage/contact_book/contact_binding.dart';
import '../../Screen/A_MenuPage/contact_book/contact_book.dart';
part 'routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [

    // GetPage(
    //   name: _Paths.MOBILE_RECHARGE,
    //   page: () => const MobileRechargeView(),
    //   binding: MobileRechargeBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ContactFrontTab,
    //   page: () => const ConatctBookFrontTab(),
    //   binding: MobileRechargeBinding(),
    // ),

    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => Splash(),

    ),

  ];
}
