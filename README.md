# INoticer

INoticer is an Android app that forwards notifications received on your Android device to an iOS device using Apple Push Notification (APN) services. This app is particularly useful for users who own both Android and iOS devices and want to receive notifications on their iOS devices without having to carry their Android phone around.

## Features

- Forward Android notifications to iOS devices via Apple Push Notification (APN).
- Supports forwarding notifications from specific apps.
- Option to upload app icons to sm.ms for display on iOS devices.
- Privacy-focused: No data is stored; notifications are directly sent to Apple servers.

## How to Use

1. Install the INoticer app on your Android device and enable the notification listener in settings.
2. Add the apps that need to forward notifications to the listening list.
3. Install the Bark app on your iOS device and fill in the Device Token in INoticer.
4. (Optional) Visit [sm.ms](https://sm.ms/), register an account, and obtain an upload token for uploading app icons.

## FAQ

### Will it leak privacy?

No, INoticer does not store any data. The app only pushes the notification content received by the Android device directly to Apple's servers. The application itself does not store the notification data.

### Why does INoticer need SMS permissions?

The text message content in Android notifications usually only contains part of the message. If you need the full content, you need to grant SMS permissions. Some manufacturers require separate permissions for SMS and notification SMS (e.g., MIUI).

### What is the Bark app?

Bark is an open-source iOS app that only receives Apple push notifications. The app does not store any data. You can find the source code for Bark [here](https://github.com/Finb/Bark). If you prefer not to use Bark, you will need to modify the Apple Push (APN) configuration in INoticer's source code and compile the APK yourself.

### How does image upload work?

INoticer automatically uploads app icons to sm.ms, a free image hosting service. If you do not want to display the app icon on iOS, you can skip this step. To upload, register an account on sm.ms and obtain an upload token.

### What if I experience repeated pushes?

Some systems may repeatedly push SMS messages through third-party apps. To resolve this issue, add blocked words in your settings (e.g., in MIUI, fill in "system freeze").

## About

INoticer is designed to solve the problem of receiving Android notifications when you own both Android and iOS devices but prefer not to carry both. The project is primarily tested on MIUI devices. The source code is available on GitHub [here](https://github.com/chbrook/INoticer).

## Recommendations

- Enable auto-start for the INoticer app.
- Disable power-saving policies that may affect the app's functionality.