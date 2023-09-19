import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_bmi_calc/constants/app_colors.dart';
import 'package:my_bmi_calc/localization/app_localization.dart';
import 'package:my_bmi_calc/routes/routes.dart';

import 'localization/localization_delegate.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: AppColors.appPrimaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appPrimaryColor,
        ),
        scaffoldBackgroundColor: AppColors.appPrimaryColor,
      ),
      initialRoute: RouteGenerator.splash,
      onGenerateRoute: RouteGenerator.generateRoute,

      locale:const Locale("vi","VI"),
      localizationsDelegates: const [
         AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:const [
        Locale.fromSubtags(languageCode: "en"),
        Locale.fromSubtags(languageCode: "vi"),
      ],
      onGenerateTitle: (context) => context.localize("title"),
      // home: const InputPage(),
    );
  }
}
