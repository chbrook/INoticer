import 'package:flutter/material.dart';
import 'package:inoticer/widget/help_item.dart';

class HelpEn extends StatelessWidget {
  const HelpEn({super.key});
  final descStyle = const TextStyle(fontSize: 14, color: Colors.black54);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Explain'),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHelpItem(
                  'How to use',
                  contentWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '1. Install the INoticer app on your Android device and enable listener in settings.',
                            style: descStyle),
                        const SizedBox(height: 8),
                        Text(
                            '2 . Add the apps that need to forward notifications to the listening list. ',
                            style: descStyle),
                        const SizedBox(height: 8),
                        Text(
                            '3. Install the Bark app on the IOS device and fill in the Device Token in INoticer.',
                            style: descStyle),
                        const SizedBox(height: 8),
                        Text(
                            '4. Visit sm.ms, register an account and obtain an upload token. (optional)',
                            style: descStyle)
                      ]),
                ),
                const SizedBox(height: 20),
                buildHelpItem(
                  'Will it leak privacy',
                  content:
                      'The application will not leak private information. INoticer only pushes the notification content received by the Android device directly to the Apple server through the phone, and the application itself does not store the notification data. ',
                ),
                const SizedBox(height: 20),
                buildHelpItem(
                  'SMS permissions',
                  content:
                      'The text message content in Android notifications usually only contains a part. If you need the full content, you need to apply for text message permissions. Some manufacturers systems need to set text message permissions and notification text message permissions separately. (such as MIUI)',
                ),
                const SizedBox(height: 20),
                buildHelpItem('Bark App',
                    content:
                        'Bark is an open source iOS app that only receives Apple push notifications. The app itself does not store notification data. Bark source code address: https://github.com/Finb/Bark.\n If you do not use Bark, you need to modify the Apple Push (APN) configuration in the INoticer source code and compile the APK yourself. '),
                const SizedBox(height: 20),
                buildHelpItem(
                  'Image upload',
                  content:
                      'The application will auto upload the App icon to sm.ms. If you do not need to display the app icon on IOS, you can not set it.\n sm .ms is a free image hosting service. You can register an account and obtain an upload token. ',
                ),
                const SizedBox(height: 20),
                buildHelpItem(
                  'Repeat push',
                  content:
                      'Some systems will read SMS messages in third-party apps Push hidden system prompts, add blocked words in settings to solve the problem. (For example, MIUI fill in "system freeze")',
                ),
                const SizedBox(height: 20),
                buildHelpItem(
                  'About INoticer',
                  content:
                      'This This is a project to solve the problem of receiving Android notification messages when holding both Android and IOS and not wanting to carry an Android phone. I only have a MIUI device, so the testing is limited. Project address: https://github.com/Finb/INoticer \n It is recommended to enable auto-start and disable power saving policy for application permissions. ',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
