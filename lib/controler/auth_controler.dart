import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../veiwe/auth_Screens/login_screen.dart';
import '../veiwe/auth_Screens/splashScreen.dart';

class AuthControler extends GetxController{
  static AuthControler instance=Get.find();
 late Rx<User?> _user;
 FirebaseAuth _auth = FirebaseAuth.instance;
 @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user=Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    ever(_user,_initioalScreen);

  }
  _initioalScreen(User? user){
    if(user ==null ){
      Get.offAll((){LoginScreen();});
    }else{
      Get.offAll(()=>const SplashScreen());
    }
  }
  void registe(String email,password){
   try{
     _auth.createUserWithEmailAndPassword(email: email, password: password);
     
   }catch(e){
     Get.snackbar("title", 'message',
       backgroundColor: Colors.deepPurple,
       titleText: const Text("Account create failed"),
       messageText: Text(e.toString())
     );
   }

  }
}