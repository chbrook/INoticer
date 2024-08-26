import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'HomeTitle': '监听应用',
          'AddTips': '请添加应用',
          'AppsTitle': '全部应用',
          'SettingsTitle': '设置',
          'ToastTile': '提示',
          'Tips1': '请先开启监听并填写Device Token',
          'Tips2': '已向指定设备发送测试通知',
          'SettingsTitle1': '启用监听',
          'SettingsSubtitle1': '开启将自动监听并转发消息到Bark',
          'SettingsTitle2': '所有应用',
          'SettingsSubtitle2': '不过滤任何通知，Bark消息不显示App名称',
          'SettingsTitle3': '读取短信',
          'SettingsSubtitle3': '开启后可获得完整短信推送',
          'SettingsTitle4': 'Device Token',
          'SettingsSubtitle4': '请填写IOS Device Token',
          'SettingsTitle5': '图床Token',
          'SettingsSubtitle5': '请填写sm.ms图床Token',
          'SettingsTitle6': '屏蔽词',
          'SettingsSubtitle6': '使用英文逗号分隔',
          'SettingsHint6': '屏蔽词1,屏蔽词2',
          'confirmText1': '确认',
          'cancelText1': '取消',
          'Tips3Title': '未设置上传Token',
          'Tips3': 'Bark接收消息将显示默认图标',
          'Tips4Title': '操作提醒',
          'Tips4': '启用监听需要重启App生效',
          'Tips4Confirm': '重启App',
          'Tips5Title': '权限提醒',
          'Tips5': '开启需要允许读取短信权限，部分系统还需要手动设置[读取通知短信]权限',
          'Tips5Custom': '去设置',
          'HelpTitle': '帮助',
          'Uploading': '上传图标中...'
        },
        'en_US': {
          'HomeTitle': 'Listening Apps',
          'AddTips': 'Please add an app',
          'AppsTitle': 'All apps',
          'SettingsTitle': 'Settings',
          'ToastTile': 'Tips',
          'Tips1': 'Please enable listening and fill in Device Token first',
          'Tips2': 'A test notification has been sent to the specified device',
          'SettingsTitle1': 'Enable listening',
          'SettingsSubtitle1':
              'Enable to auto listen and forward messages to Bark',
          'SettingsTitle2': 'All applications',
          'SettingsSubtitle2':
              'Do not filter any notifications, Bark messages do not display the App name',
          'SettingsTitle3': 'Read SMS',
          'SettingsSubtitle3': 'After enabling, you can get complete SMS push',
          'SettingsTitle4': 'Device Token',
          'SettingsSubtitle4': 'Please fill in IOS Device Token',
          'SettingsTitle5': 'Image Host Token',
          'SettingsSubtitle5': 'Please fill in sm.ms Image Host Token',
          'SettingsTitle6': 'Blocked Words',
          'SettingsSubtitle6': 'Use English commas to separate',
          'SettingsHint6': 'Blocked Words 1, Blocked Words 2',
          'confirmText1': 'Confirm',
          'cancelText1': 'Cancel',
          'Tips3Title': 'Upload Token is not set',
          'Tips3': 'Bark will display the default icon when receiving messages',
          'Tips4Title': 'Operation reminder',
          'Tips4':
              'Enabling monitoring requires restarting the App to take effect',
          'Tips4Confirm': 'Restart the App',
          'Tips5Title': 'Permission reminder',
          'Tips5':
              'Enabling requires permission to read SMS messages. Some systems also require manual setting of the [Read notification SMS] permission',
          'Tips5Custom': 'Go to settings',
          'Uploading': 'Icon uploading...'
        }
      };
}
