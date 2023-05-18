import 'package:flutter/material.dart';

class LangProvider extends ChangeNotifier {

  bool bangLang = false;
  bool darkTheme = false;
  int themeView = 0;


  changeLang(lang) {
    bangLang = lang ;

    notifyListeners();
  }

  changeTheme(theme) {
    darkTheme = theme ;

    notifyListeners();
  }

  changeThemeView(theme) {
    themeView = theme ;

    notifyListeners();
  }


}
