
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routs/routs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), ()=>chooseScreen());
    super.initState();
  }
  final box=GetStorage();
  Future chooseScreen()async{
    var userId= box.read("uid");
    if(userId==null){
      Get.toNamed(onboarding);
    }else{
      Get.toNamed(mainhomeScreen);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(),
              SizedBox(height: 10.h,),
               Text('appName'.tr)
            ],
          ),
        ),
      ),
    );
  }
}
