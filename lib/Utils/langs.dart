enum AppLanguage { English, Bangla }

/// Returns enum value name without enum class name.
String enumName(AppLanguage anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appLanguageData = {
  AppLanguage.English: {"value": "en", "name": "English", "locale": "en_US"},
  AppLanguage.Bangla: {"value": "ar", "name": "Bangla", "locale": "ar_AE"},
};
