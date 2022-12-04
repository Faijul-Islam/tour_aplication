import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tour_aplication/model/const/textStyle.dart';
import 'package:tour_aplication/model/widget/drawer_item.dart';
import 'package:tour_aplication/veiwe/routs/routs.dart';
import 'package:launch_review/launch_review.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.h, left: 20.w, bottom: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 62.h,),
            Text(
              "Shelter".tr,
              style: TextStyle(
                fontSize: 25.sp,fontWeight: FontWeight.w700
              ),
            ),
            Text(
              "travelAgency".tr,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 47.h,),
            drawerItem("support".tr, () {
              Get.toNamed(supportScreen);
            }),
            drawerItem("privacy".tr, () {
               Get.toNamed(privacyScreen);
            }),
            drawerItem("FAQ".tr, () {
               Get.toNamed(faqScreen);
            }),
            drawerItem("rateUs".tr, ()=>LaunchReview.launch(
              androidAppId: "com.example.tour_application",
            )),
            drawerItem("howtouse".tr, () {
                Get.toNamed(howToUseScreen);
            }),
            const Expanded(child: SizedBox()),
            drawerItem("setting".tr, () {
               Get.toNamed(settingScreen);
            }),
          ],
        ),
      ),
    );
  }
}
