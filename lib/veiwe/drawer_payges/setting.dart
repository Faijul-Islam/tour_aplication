import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tour_aplication/const/app_thime.dart';
import 'package:tour_aplication/model/widget/drawer_item.dart';

import '../routs/routs.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  RxBool darkTheme = false.obs;
  var textValue = 'Switch is OFF';
  final box = GetStorage();

  Future _exitDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text("areu".tr),
            content: Row(
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text("no".tr),
                ),
                SizedBox(
                  width: 20.w,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().then((value) =>
                        Fluttertoast.showToast(msg: "Logout Successfully"));
                    await box.remove("uid");
                    Get.toNamed(splash);
                  },
                  child: Text("yes".tr),
                ),
              ],
            ),
          );
        });
  }

  Future _language(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("chuseyourlanguage".tr),
            content: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Get.updateLocale(
                      const Locale("bn", "BD"),
                    );
                    Get.back();
                  },
                  child: Text("bangla".tr),
                ),
                SizedBox(
                  width: 20.w,
                ),
                TextButton(
                  onPressed: () {
                    Get.updateLocale(
                      const Locale("en", "US"),
                    );
                    Get.back();
                  },
                  child: Text("english".tr),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "setting".tr,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("darkMode/lightMode".tr),
                  Obx(() => Switch(
                        onChanged: (bool value) {
                          darkTheme.value = value;
                          Get.changeTheme(darkTheme.value == false
                              ? AppTheme().lightTheme(context)
                              : AppTheme().darkTheme(context));
                          box.write('theme', darkTheme.value);
                        },
                        value: darkTheme.value,
                      ))
                ],
              ),
              drawerItem("logout".tr, () {
                _exitDialog(context);
              }),
              drawerItem("profile".tr, () {
                Get.toNamed(profileScreen);
              }),
              drawerItem("language".tr, () {
                _language(context);
              }),
              drawerItem("my password".tr, () {
                Get.toNamed(myPassword);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
