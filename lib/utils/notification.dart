import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:inoticer/api/apn.dart';
import 'package:inoticer/controller/config_controller.dart';

String? lastMsg;

class ExNotificationListener {
  ExNotificationListener() {
    _init();
  }

  Future<void> _init() async {
    bool? hasPermission = await NotificationsListener.hasPermission;
    if (!hasPermission!) {
      NotificationsListener.openPermissionSettings();
      return;
    } else {
      initPlatformState();
    }
  }

  Future<void> initPlatformState() async {
    NotificationsListener.initialize(callbackHandle: _callback);
    Locale systemLocale = PlatformDispatcher.instance.locale;
    systemLocale.countryCode == 'CN'
        ? NotificationsListener.startService(
            title: 'INoticer服务', description: '监听通知消息')
        : NotificationsListener.startService(
            title: 'INoticer service',
            description: 'Listen for notification messages');
  }

  static String takeContent(String? text) {
    final regex = RegExp(r'^\[.*?\].*?:\s*(.*)');
    final match = regex.firstMatch(text!);
    final result = match != null ? match.group(1) : text;
    return result ?? '';
  }

  @pragma('vm:entry-point')
  static void _callback(NotificationEvent evt) async {
    ConfigController configController = Get.find();

    if (configController.config['unFilter']) {
      final result = takeContent(evt.text);
      sendNotification(evt.title ?? '', result, '');
    }
    print(evt);
    Map checkedApp = configController.checkedApps
        .firstWhere((element) => element['packageName'] == evt.packageName);

    bool inBlocked = configController.config['blockedWords']
        .any((element) => evt.text!.contains(element));

    if (configController.checkedApps.isNotEmpty && !inBlocked) {
      final result = takeContent(evt.text);

      void sendNoitce() {
        sendNotification(checkedApp['name'], '${evt.title}：$result',
            checkedApp['icon'] ?? '');
      }

      bool readSMS = configController.config['readSMS'];
      if (evt.packageName == 'com.android.mms' && readSMS) {
        SmsQuery query = SmsQuery();
        List<SmsMessage> messages = await query
            .querySms(kinds: [SmsQueryKind.inbox], start: 0, count: 1);

        if (messages.isEmpty) {
          return sendNoitce();
        }
        return sendNotification(
            checkedApp['name'],
            '${messages[0].address}：${messages[0].body}',
            checkedApp['icon'] ?? '');
      }
      sendNoitce();
    }
    final SendPort send = IsolateNameServer.lookupPortByName('_listener_')!;
    send.send(evt);
  }
}
