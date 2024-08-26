import 'package:flutter/material.dart';
import 'package:inoticer/widget/help_item.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  final descStyle = const TextStyle(fontSize: 14, color: Colors.black54);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('说明'),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHelpItem(
                  '如何使用',
                  contentWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1. 在Android设备上安装INoticer应用，并在设置中启用监听。',
                            style: descStyle),
                        const SizedBox(height: 8),
                        Text('2. 将需要转发通知的App添加到监听列表。', style: descStyle),
                        const SizedBox(height: 8),
                        Text('3. 在IOS设备上安装Bark应用，并将Device Token填写到INoticer中。',
                            style: descStyle),
                        const SizedBox(height: 8),
                        Text('4. 访问sm.ms，注册账号并获取一个上传token。(非必须)',
                            style: descStyle)
                      ]),
                ),
                const SizedBox(height: 20),
                buildHelpItem(
                  '是否会泄露隐私',
                  content:
                      '应用不会泄露隐私信息。INoticer只是将Android设备接收到的通知内容通过手机直接推送到苹果服务器，应用本身不存储通知数据。',
                ),
                const SizedBox(height: 20),
                buildHelpItem(
                  '短信权限',
                  content:
                      'Android通知中的短信内容通常只包含一部分，如果需要完整内容，需要申请短信权限。部分厂家系统需要分别设置短信权限和通知短信权限。(如MIUI)',
                ),
                const SizedBox(height: 20),
                buildHelpItem('Bark App',
                    content:
                        'Bark是一个开源的IOS App，只负责接收苹果推送，应用本身不存储通知数据。Bark的源码地址：https://github.com/Finb/Bark。\n 不使用Bark的话，需要自己修改INoticer源码中苹果推送(APN)配置并自行编译APK。'),
                const SizedBox(height: 20),
                buildHelpItem(
                  '图片上传',
                  content:
                      '应用会自动将App图标上传到sm.ms，如果在IOS上不需要显示应用图标，可以不设置。\n sm.ms是一个免费图床，可以自行注册账号并获取上传token。',
                ),
                const SizedBox(height: 20),
                buildHelpItem(
                  '重复推送',
                  content:
                      '某些系统会在第三方App读取短信时推送隐藏系统提示，在设置中添加屏蔽词即可解决。(如MIUI填写“系统卡顿”)',
                ),
                const SizedBox(height: 20),
                buildHelpItem(
                  '关于INoticer',
                  content:
                      '这是一个用来解决Android和IOS双持时，不想携带Android手机的情况下接收Android通知消息的项目，本人只有MIUI设备，测试有限。项目地址：https://github.com/Finb/INoticer \n 建议应用权限开启自启动和关闭省电策略。',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
