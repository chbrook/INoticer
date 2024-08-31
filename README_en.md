English | [__中文__](./README.md)

# INoticer

INoticer is an Android app that forwards notifications received on Android devices to iOS devices using the Apple Push Notification (APN) service. It is especially useful for users who have both Android and iOS devices and want to receive notifications on iOS devices without carrying an Android phone.

## Features

- Forward Android notifications to iOS devices via Apple Push Notification (APN).
- Supports forwarding notifications for specific apps.
- Optionally upload app icons to sm.ms to display on iOS devices.
- Privacy-focused: no data is stored; notifications are sent directly to Apple servers.

## How to use

1. Install the INoticer app on your Android device and enable notification listeners in settings.
2. Add apps that need to forward notifications to the listening list.
3. Install the Bark app on your iOS device and fill in the device token in INoticer.
4. (Optional) Visit [sm.ms](https://sm.ms/), register an account, and obtain an upload token for uploading the app icon.

## FAQ

### Will it leak privacy?

No, INoticer does not store any data. The app only pushes the notification content received by the Android device directly to Apple's server.

### Why does INoticer need SMS permission?

The SMS content in Android notifications usually only contains part of the message. If you need the full content, you need to grant SMS permission. Some manufacturers require separate permissions for SMS and notification SMS (such as MIUI).

### What is the Bark app?

Bark is an open source iOS app that only receives Apple push notifications. The app does not store any data. You can find the source code of Bark [here](https://github.com/Finb/Bark). If you do not want to use Bark, you need to modify the Apple Push (APN) configuration in the INoticer source code and compile the APK yourself.

### How does image upload work?

INoticer automatically uploads the app icon to sm.ms, a free image hosting service. If you don't want to display the app icon on iOS, you can skip this step. To upload, register an account on sm.ms and get an upload token.

### What if I experience repeated push notifications?

Some systems may push SMS messages repeatedly through third-party apps. To solve this problem, add a blocked word in the settings (for example, fill in "system lag" in MIUI).

### Why use Profile mode?

Flutter's Tree shake optimization will cause the auto-started notification listening service to not work properly and may miss notifications. Profile mode can solve this problem.

## About

INoticer aims to solve the problem of receiving Android notifications when you have both Android and iOS devices but don't want to carry both. The project is mainly tested on MIUI devices. The source code can be found on GitHub [here](https://github.com/chbrook/INoticer).

## Recommendations

- Enable auto-start for the INoticer app.
- Disable power saving policies that may affect the app's functionality.