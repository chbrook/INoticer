import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inoticer/api/apn.dart';
import 'package:inoticer/controller/config_controller.dart';
import 'package:inoticer/utils/common.dart';
import 'package:inoticer/widget/input_item.dart';
import 'package:inoticer/widget/switch_item.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: Text('SettingsTitle'.tr),
          titleSpacing: 0,
          actions: [
            IconButton(
                onPressed: () {
                  if (!configController.config['openPush'] ||
                      configController.config['deviceToken'] == '') {
                    showToast('ToastTile'.tr, 'Tips1'.tr);
                  } else {
                    sendNotification(configController.config['deviceToken'],
                        'Test', 'This is a test message', '');
                    showToast('ToastTile'.tr, 'Tips2'.tr);
                  }
                },
                icon: const Icon(Icons.send)),
            IconButton(
                onPressed: () {
                  Locale systemLocale = PlatformDispatcher.instance.locale;
                  Get.toNamed(
                      systemLocale.countryCode == 'CN' ? '/help' : '/help_en');
                },
                icon: const Icon(Icons.help)),
            const SizedBox(width: 20)
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
                child: Obx(
          () => Column(
            children: [
              buildSwitchItem(
                onChanged: (value) =>
                    configController.updateConfig('openPush', value),
                title: 'SettingsTitle1'.tr,
                subtitle: 'SettingsSubtitle1'.tr,
                value: configController.config['openPush'],
              ),
              buildSwitchItem(
                onChanged: (value) =>
                    configController.updateConfig('unFilter', value),
                title: 'SettingsTitle2'.tr,
                subtitle: 'SettingsSubtitle2'.tr,
                value: configController.config['unFilter'],
              ),
              buildSwitchItem(
                onChanged: (value) =>
                    configController.updateConfig('readSMS', value),
                title: 'SettingsTitle3'.tr,
                subtitle: 'SettingsSubtitle3'.tr,
                value: configController.config['readSMS'],
              ),
              buildInputItem(
                initValue: configController.config['deviceToken'],
                onSubmitted: (value) =>
                    configController.updateConfig('deviceToken', value),
                title: 'SettingsTitle4'.tr,
                subtitle: 'SettingsSubtitle4'.tr,
                hintText: '05f633d******867',
              ),
              buildInputItem(
                initValue: configController.config['iconUploadToken'],
                onSubmitted: (value) =>
                    configController.updateConfig('iconUploadToken', value),
                title: 'SettingsTitle5'.tr,
                subtitle: 'SettingsSubtitle5'.tr,
                hintText: 'bsp0esw******wwG',
              ),
              buildInputItem(
                initValue:
                    configController.config['blockedWords']?.join(',') ?? '',
                onSubmitted: (value) => configController.updateConfig(
                    'blockedWords', value.split(',')),
                title: 'SettingsTitle6'.tr,
                subtitle: 'SettingsSubtitle6'.tr,
                hintText: 'SettingsHint6'.tr,
              ),
            ],
          ),
        ))));
  }
}
