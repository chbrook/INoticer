import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void showModal(String title, String message,
    {Function? onConfirm,
    String? confirmText,
    Function? onCancel,
    List<Widget>? moreActions}) {
  Get.dialog(AlertDialog(
    shape: ShapeBorder.lerp(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      null,
      0.0,
    ),
    title: Text(title),
    content: Text(message),
    actions: [
      ...?moreActions,
      TextButton(
        child: Text(confirmText ?? 'confirmText1'.tr),
        onPressed: () {
          if (onConfirm != null) {
            onConfirm();
          }

          Get.back();
        },
      ),
      TextButton(
        child: Text(
          'cancelText1'.tr,
          style: const TextStyle(color: Colors.grey),
        ),
        onPressed: () => onCancel ?? Get.back(),
      ),
    ],
  ));
}

Future<bool> checkSmsPermission() async {
  PermissionStatus status = await Permission.sms.status;

  if (status.isGranted) {
    return true;
  } else if (status.isDenied || status.isPermanentlyDenied) {
    PermissionStatus newStatus = await Permission.sms.request();
    if (newStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  return false;
}

Future<void> openAppSettings() async {
  const platform = MethodChannel('app_settings');
  try {
    await platform.invokeMethod('openAppSettings');
  } on PlatformException catch (e) {
    print("Failed to open app settings: '${e.message}'.");
  }
}

void showLoading(String title) {
  Get.dialog(
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.green),
          ),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none))
        ],
      )),
      barrierColor: Colors.transparent);
}

void hideLoading() {
  if (Get.isDialogOpen == true) {
    Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
  }
}

void showToast(String title, String message, {int? duration}) {
  Get.snackbar(title, message,
      backgroundColor: Colors.white70,
      borderColor: Colors.black12,
      borderWidth: 1,
      icon: const Icon(Icons.info, color: Colors.green),
      duration: Duration(seconds: duration ?? 3));
}
