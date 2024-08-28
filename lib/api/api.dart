import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:inoticer/controller/config_controller.dart';
import 'package:inoticer/utils/common.dart';

class Api extends GetConnect {
//use webkook to push notice(deprecated)
  Future<void> sendNotice(String title, String body, String icon) async {
    ConfigController configController = Get.find();
    Response response = await post(configController.config['apiUrl'],
        {'title': title, 'body': body, 'icon': icon});

    if (response.statusCode != 200) {}
  }

  //use webkook to push notice(deprecated)
  Future<void> test(String tag) async {
    Response response = await get('http://192.168.2.116:8080?query=$tag');

    if (response.statusCode != 200) {}
  }

//upload icon to sm.ms
  Future<String> uploadIcon(Uint8List icon) async {
    ConfigController configController = Get.find();
    if (configController.config['iconUploadToken'] == '') {
      showToast('Tips3Title'.tr, 'Tips3'.tr, duration: 4);
      return '';
    }

    final form =
        FormData({'smfile': MultipartFile(icon, filename: 'icon.png')});
    Response response = await post('https://sm.ms/api/v2/upload', form,
        headers: {'Authorization': configController.config['iconUploadToken']});

    if (response.statusCode == 200) {
      Map responseData = response.body;
      return responseData['data'] is Map
          ? responseData['data']['url']
          : responseData['images'];
    }

    return '';
  }
}
