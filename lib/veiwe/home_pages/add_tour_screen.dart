import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/widget/text_fild.dart';
import '../../model/widget/vaioletButton.dart';
import '../routs/routs.dart';
import 'nav_add_last_step.dart';

class AddTourScren extends StatelessWidget {
   AddTourScren({Key? key}) : super(key: key);
  final TextEditingController _0wnerName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _Cost = TextEditingController();
  final TextEditingController _facilities = TextEditingController();
  final TextEditingController _destination = TextEditingController();
   final RxBool _value = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text(
                  "problem".tr,
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                customTextField("ownerName".tr,_0wnerName),
                customTextField("description".tr,_description),
                customTextField("Cost",_Cost),
                customTextField("facilities".tr,_facilities, maxline: 4),
                customTextField("destination".tr,_destination),
                VioletButton("next".tr, (){
                  Get.toNamed(
                      navAddLastStep,
                    arguments: NavAddLastStep(
                      name: _0wnerName.text,
                      description: _description.text,
                      cost: _Cost.text,
                      facility: _facilities.text,
                      destination: _destination.text,
                    ),
                  );
                  _0wnerName.clear();
                  _description.clear();
                  _Cost.clear();
                  _facilities.clear();
                  _destination.clear();

                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
