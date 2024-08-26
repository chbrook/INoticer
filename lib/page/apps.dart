import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inoticer/controller/config_controller.dart';
import 'package:installed_apps/installed_apps.dart';

//installed appliction list
class Apps extends StatelessWidget {
  const Apps({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigController configController = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: Text('AppsTitle'.tr),
          titleSpacing: 0,
        ),
        body: FutureBuilder(
            future: InstalledApps.getInstalledApps(true, true),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                ));
              } else {
                List appList = snapshot.data;

                return ListView.builder(
                    itemCount: appList.length,
                    itemBuilder: (context, index) => ListTile(
                          leading: Image.memory(appList[index].icon!,
                              width: 50, height: 50),
                          title: Text(appList[index].name),
                          subtitle: Text(
                            appList[index].packageName,
                            style: const TextStyle(color: Colors.black45),
                          ),
                          trailing: Transform.scale(
                              scale: 0.8,
                              child: Obx(() => CupertinoSwitch(
                                    value:
                                        configController.checkedApps.isNotEmpty
                                            ? configController.checkedApps.any(
                                                (element) =>
                                                    element['packageName'] ==
                                                    appList[index].packageName)
                                            : false,
                                    onChanged: (status) =>
                                        configController.updateCheckedApps(
                                            appList[index], status),
                                  ))),
                        ));
              }
            }));
  }
}
