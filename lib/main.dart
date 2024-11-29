import 'dart:io';
import 'package:engineer/app_router.dart';
import 'package:engineer/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:engineer/providers/localizations.dart';

// ฟังก์ชันในการดึงข้อมูลจาก SharedPreferences
Future<String?> getLanguageCode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('languageCode');
}

// ฟังก์ชันในการบันทึกข้อมูลลงใน SharedPreferences
Future<void> setLanguageCode(String code) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('languageCode', code);
}

// กำหนดตัวแปร initialRoute ให้กับ MaterialApp
var initialRoute;
// กำหนดตัวแปร locale ให้กับ Provider
var locale;
dynamic initRoute;
void main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // เรียกใช้ SharedPreferences
  String? languageCode = await getLanguageCode();
  locale = Locale(languageCode ?? 'en');

  initRoute = prefs.getBool('welcomeStatus') == true
      ? AppRouter.home
      : AppRouter.welcome;

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(locale),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Provider.of<LocaleProvider>(context).locale,
      title: 'Engineer App',
      initialRoute: initRoute,
      routes: AppRouter.routes,
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
