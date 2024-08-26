import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inoticer/controller/config_controller.dart';
import 'package:inoticer/language/messages.dart';
import 'package:inoticer/route/router.dart';

void main() async {
  await GetStorage.init();
  Get.put(ConfigController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Locale systemLocale = PlatformDispatcher.instance.locale;
    return GetMaterialApp(
        title: 'INoticer',
        translations: Messages(),
        locale: systemLocale,
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        initialRoute: '/',
        getPages: routes);
  }
}
