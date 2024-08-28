import 'dart:convert';
import 'dart:ui';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:inoticer/api/apn.dart';
import 'package:inoticer/utils/prefs.dart';

class ExNotificationListener {
  static Future<void> initPlatformState() async {
    final bool? hasPermission = await NotificationsListener.hasPermission;
    if (!hasPermission!) {
      return NotificationsListener.openPermissionSettings();
    }
    NotificationsListener.initialize(callbackHandle: _callback);

    Locale systemLocale = PlatformDispatcher.instance.locale;
    systemLocale.countryCode == 'CN'
        ? NotificationsListener.startService(
            title: 'INoticer服务', description: '监听通知消息')
        : NotificationsListener.startService(
            title: 'INoticer service',
            description: 'Listen for notification messages');
  }

  @pragma('vm:entry-point')
  static void _callback(NotificationEvent evt) async {
    final String? cacheConfigStr = await prefs.getString('config');
    final String? cacheCheckedAppsStr = await prefs.getString('checkedApps');
    final Map cacheConfig = jsonDecode(cacheConfigStr ?? '{}');
    final List cacheCheckedApps = jsonDecode(cacheCheckedAppsStr ?? '[]');

    if (cacheConfig['unFilter']) {
      final result = takeContent(evt.text);
      return sendNotification(
          cacheConfig['deviceToken'], evt.title ?? '', result, '');
    }

    Map checkedApp = cacheCheckedApps
        .firstWhere((element) => element['packageName'] == evt.packageName);

    bool inBlocked = cacheConfig['blockedWords']
        .any((element) => evt.text!.contains(element));

    if (cacheCheckedApps.isNotEmpty && !inBlocked) {
      final result = takeContent(evt.text);

      void sendNoitce() {
        sendNotification(cacheConfig['deviceToken'], checkedApp['name'],
            '${evt.title}：$result', checkedApp['icon'] ?? '');
      }

      if (evt.packageName == 'com.android.mms' && cacheConfig['readSMS']) {
        SmsQuery query = SmsQuery();
        List<SmsMessage> messages = await query
            .querySms(kinds: [SmsQueryKind.inbox], start: 0, count: 1);

        if (messages.isEmpty) {
          return sendNoitce();
        }
        return sendNotification(
            cacheConfig['deviceToken'],
            checkedApp['name'],
            '${messages[0].address}：${messages[0].body}',
            checkedApp['icon'] ?? '');
      }
      sendNoitce();
    }
  }

  static String takeContent(String? text) {
    final regex = RegExp(r'^\[.*?\].*?:\s*(.*)');
    final match = regex.firstMatch(text!);
    final result = match != null ? match.group(1) : text;
    return result ?? '';
  }
}
