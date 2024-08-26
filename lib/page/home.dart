import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inoticer/controller/config_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigController configController = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeTitle'.tr),
          actions: [
            IconButton(
                onPressed: () => Get.toNamed('/settings'),
                icon: const Icon(Icons.settings)),
            const SizedBox(width: 20)
          ],
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, right: 20.0),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () {
                Get.toNamed('/apps');
              },
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.green,
              ),
            )),
        body: Obx(() => configController.checkedApps.isEmpty
            ? Center(
                child: Tab(
                  height: 100,
                  icon: const Icon(
                    Icons.apps,
                    size: 60,
                    color: Colors.grey,
                  ),
                  child: Text(
                    'AddTips'.tr,
                    style: const TextStyle(
                      color: Colors.grey, // 文字颜色
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: configController.checkedApps.length,
                itemBuilder: (context, index) => ListTile(
                    leading: configController.checkedApps[index]['icon'] != ''
                        ? Image.network(
                            configController.checkedApps[index]['icon'],
                            width: 50,
                            height: 50,
                            cacheWidth: 300,
                            cacheHeight: 300,
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.5))),
                            child: const Icon(Icons.apps),
                          ),
                    title: Text(configController.checkedApps[index]['name']),
                    subtitle: Text(
                      configController.checkedApps[index]['packageName'],
                      style: const TextStyle(color: Colors.black45),
                    ),
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        value: true,
                        onChanged: (status) =>
                            configController.removeCheckedApp(
                                configController.checkedApps[index]),
                      ),
                    )))));
  }
}
