中文 | [__English__](./README_en.md)

# INoticer

INoticer 是一款 Android 应用，它使用 Apple Push Notification (APN) 服务将 Android 设备上收到的通知转发到 iOS 设备。对于同时拥有 Android 和 iOS 设备并希望在 iOS 设备上接收通知而无需随身携带 Android 手机的用户特别有用。

## 功能

- 通过 Apple Push Notification (APN) 将 Android 通知转发到 iOS 设备。
- 支持转发特定应用的通知。
- 可选择将应用图标上传到 sm.ms 以在 iOS 设备上显示。
- 注重隐私：不存储任何数据；通知直接发送到 Apple 服务器。

## 使用方法

1. 在您的 Android 设备上安装 INoticer 应用并在设置中启用通知监听器。
2. 将需要转发通知的应用添加到监听列表。
3. 在您的 iOS 设备上安装 Bark 应用并在 INoticer 中填写设备令牌。
4. （可选）访问 [sm.ms](https://sm.ms/)，注册一个账号，获取一个用于上传应用图标的上传 token。

## 常见问题

### 会泄露隐私吗？

不会，INoticer 不存储任何数据。应用只将 Android 设备收到的通知内容直接推送到苹果的服务器。

### 为什么 INoticer 需要短信权限？

Android 通知中的短信内容通常只包含部分消息。如果需要完整内容，则需要授予短信权限。有些制造商要求对短信和通知短信分别授予权限（例如 MIUI）。

### 什么是 Bark App？

Bark 是一个开源的 iOS 应用，只接收苹果推送通知。应用不存储任何数据。你可以在 [这里](https://github.com/Finb/Bark) 找到 Bark 的源代码。如果您不想使用 Bark，则需要修改 INoticer 源代码中的 Apple Push (APN) 配置并自行编译 APK。

### 图片上传如何工作？

INoticer 会自动将应用图标上传到 sm.ms，这是一个免费的图片托管服务。如果您不想在 iOS 上显示应用图标，则可以跳过此步骤。要上传，请在 sm.ms 上注册一个帐户并获取上传令牌。

### 如果我遇到重复推送怎么办？

某些系统可能会通过第三方应用重复推送短信。要解决此问题，请在设置中添加屏蔽词（例如，在 MIUI 中填写“系统卡顿”）。

## 关于

INoticer 旨在解决当您同时拥有 Android 和 iOS 设备但不想同时携带时接收 Android 通知的问题。该项目主要在 MIUI 设备上进行测试。源代码可在 GitHub [此处](https://github.com/chbrook/INoticer) 上找到。

## 建议

- 为 INoticer 应用启用自动启动。
- 禁用可能影响应用功能的省电策略。