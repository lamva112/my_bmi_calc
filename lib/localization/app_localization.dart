import 'package:flutter/material.dart';

/// Adds an useful localization method on a [BuildContext]
extension LocalizationExt on BuildContext {
  String localize(String value) {
    final code = AppLocalization.of(this).locale.languageCode;
    final database = AppLocalization.localizedValues;

    if (database.containsKey(code)) {
      return database[code]?[value] ?? "-";
    } else {
      return database["en"]?[value] ?? "-";
    }
  }
}

/// This class is responsible of translating strings into a certain
/// languages defined by the [Locale] passed in the constructor.
class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization)!;

  static Map<String, Map<String, String>> localizedValues = {
    "en": {
      "title": "BMI CALCULATOR",
      "calculate": "CALCULATE",
      "male":"MALE",
      "female":"FEMALE",
      "height":"HEIGHT",
      "weight":"WEIGHT",
      "age":"AGE",
      "history":"HISTORY"
    },
    "vi": {
      "title": "Công cụ tính BMI",
      "calculate": "Tính BMI",
      "male":"NAM",
      "female":"NỮ",
      "height":"CHIỀU CAO",
      "weight":"CÂN NẶNG",
      "age":"TUỔI",
      "history":"Lịch sử"
    },
  };
}
