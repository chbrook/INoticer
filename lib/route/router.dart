import 'package:get/get.dart';
import 'package:inoticer/page/apps.dart';
import 'package:inoticer/page/help.dart';
import 'package:inoticer/page/help_en.dart';
import 'package:inoticer/page/home.dart';
import 'package:inoticer/page/settings.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/', page: () => const Home()),
  GetPage(
      name: '/settings',
      page: () => const Settings(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/apps', page: () => const Apps(), transition: Transition.downToUp),
  GetPage(
      name: '/help',
      page: () => const Help(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/help_en',
      page: () => const HelpEn(),
      transition: Transition.rightToLeft),
];
