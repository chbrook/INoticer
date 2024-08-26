import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:inoticer/api/api.dart';
import 'package:inoticer/utils/common.dart';
import 'package:inoticer/utils/notification.dart';
import 'package:inoticer/utils/storage.dart';
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
    var cacheConfig = storage.read('config');
    var cacheCheckedApps = storage.read('checkedApps');
    if (cacheConfig != null) {
      config = RxMap.from(cacheConfig);
    }
    if (cacheCheckedApps != null) {
      checkedApps = RxList.from(cacheCheckedApps);
    }

    if (config['openPush']) {
      ExNotificationListener();
    }
  }

  void updateCheckedApps(app, bool status) async {
    bool exist =
        checkedApps.any((element) => element['packageName'] == app.packageName);

    if (status && !exist) {
      showLoading('Uploading'.tr);
      String iconUrl = await Api().uploadIcon(app.icon!);
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
    storage.write('checkedApps', checkedApps);
  }

  void removeCheckedApp(app) async {
    checkedApps
        .removeWhere((element) => element['packageName'] == app['packageName']);
    storage.write('checkedApps', checkedApps);
  }

  void updateConfig(String key, dynamic value) async {
    if (key == 'readSMS' && value) {
      return setSms(key, value);
    }
    if (key == 'openPush') {
      return setOpenPush(key, value);
    }
    config[key] = value;
    await storage.write('config', config);
  }

  void setOpenPush(key, value) async {
    if (!value) {
      config[key] = value;
      await storage.write('config', config);
      NotificationsListener.stopService();
    } else {
      bool? hasPermission = await NotificationsListener.hasPermission;
      if (!hasPermission!) {
        NotificationsListener.openPermissionSettings();
      } else {
        config[key] = value;
        await storage.write('config', config);
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
        storage.write('config', config);
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
