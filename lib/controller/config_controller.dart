import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:inoticer/api/api.dart';
import 'package:inoticer/utils/common.dart';
import 'package:inoticer/utils/notification.dart';
import 'package:inoticer/utils/prefs.dart';
import 'package:installed_apps/app_info.dart';
import 'package:restart_app/restart_app.dart';

class ConfigController extends GetxController {
  RxMap config = {
    'openPush': false,
    'readSMS': false,
    'unFilter': false,
    'deviceToken': '',
    'iconUploadToken': '',
    'blockedWords': [],
    'apiUrl': '',
  }.obs;

  RxList checkedApps = [].obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    final String? cacheConfigStr = await prefs.getString('config');
    final String? cacheCheckedAppsStr = await prefs.getString('checkedApps');

    if (cacheConfigStr != null) {
      final cacheConfig = jsonDecode(cacheConfigStr);
      config.assignAll(Map<String, Object>.from(cacheConfig));
    } else {
      await prefs.setString('config', jsonEncode(config));
    }

    if (cacheCheckedAppsStr != null) {
      final cacheCheckedApps = jsonDecode(cacheCheckedAppsStr);
      checkedApps.assignAll(cacheCheckedApps);
    } else {
      await prefs.setString('checkedApps', jsonEncode(checkedApps));
    }

    if (config['openPush']) {
      ExNotificationListener.initPlatformState();
    }
  }

  void updateCheckedApps(AppInfo app, bool status) async {
    final exist =
        checkedApps.any((element) => element['packageName'] == app.packageName);

    if (status && !exist) {
      showLoading('Uploading'.tr);

      final iconUrl = app.icon != null ? await Api().uploadIcon(app.icon!) : '';
      print(iconUrl);

      checkedApps.add(
          {'packageName': app.packageName, 'name': app.name, 'icon': iconUrl});

      hideLoading();
    } else if (exist) {
      checkedApps
          .removeWhere((element) => element['packageName'] == app.packageName);
    } else {
      return;
    }
    await prefs.setString('checkedApps', jsonEncode(checkedApps));
  }

  void removeCheckedApp(app) async {
    checkedApps
        .removeWhere((element) => element['packageName'] == app['packageName']);
    await prefs.setString('checkedApps', jsonEncode(checkedApps));
  }

  void updateConfig(String key, dynamic value) async {
    if (key == 'readSMS' && value) {
      return setSms(key, value);
    }
    if (key == 'openPush') {
      return setOpenPush(key, value);
    }
    config[key] = value;
    await prefs.setString('config', jsonEncode(config));
  }

  void setOpenPush(key, value) async {
    if (!value) {
      config[key] = value;
      await prefs.setString('config', jsonEncode(config));
      NotificationsListener.stopService();
    } else {
      bool? hasPermission = await NotificationsListener.hasPermission;
      if (!hasPermission!) {
        NotificationsListener.openPermissionSettings();
      } else {
        config[key] = value;
        await prefs.setString('config', jsonEncode(config));
        showModal('Tips4Title'.tr, 'Tips4'.tr, confirmText: 'Tips4Confirm'.tr,
            onConfirm: () {
          Restart.restartApp();
        });
      }
    }
  }

  void setSms(key, value) {
    Future<void> requstPermission() async {
      bool hasPermission = await checkSmsPermission();
      print(hasPermission);
      if (hasPermission) {
        SmsQuery query = SmsQuery();
        await query.querySms(kinds: [SmsQueryKind.inbox], start: 0, count: 1);

        config[key] = value;
        await prefs.setString('config', jsonEncode(config));
      }
    }

    showModal('Tips5Title'.tr, 'Tips5'.tr,
        onConfirm: requstPermission,
        moreActions: [
          TextButton(
            onPressed: () async {
              Get.back();
              openAppSettings();
            },
            child: Text('Tips5Custom'.tr),
          )
        ]);
  }
}
