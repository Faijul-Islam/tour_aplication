import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tour_aplication/model/widget/vaioletButton.dart';
import '../../veiwe/routs/routs.dart';

class Auth {
  final box = GetStorage();
  Future registration(String emailAddress, String password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Registration Successful');
        box.write('uid', authCredential.uid);
        Get.toNamed(usersForm);
      } else {
        Fluttertoast.showToast(msg: 'sign up failed');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error is: $e');
    }
  }

  Future login(String emailAddress, String password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Login Successful');
        box.write('uid', authCredential.uid);
        Get.toNamed(mainhomeScreen);
      } else {
        Fluttertoast.showToast(msg: 'sign up failed');

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error is: $e');
    }
  }

  Future singinwithPhone(number, context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user!.uid.isNotEmpty) {
          box.write('uid', user.uid);
          Get.toNamed(usersForm);
        } else {
          Fluttertoast.showToast(msg: 'failed');
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        if (e.code == 'invalid-phone-number') {
          Fluttertoast.showToast(msg: 'The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            builder: (_) {
              final otpControler = TextEditingController();
              return AlertDialog(
                title: const Text("Enter your otp"),
                content: Column(
                  children: [
                    TextField(
                      controller: otpControler,
                    ),
                    VioletButton("title", () async {
                      PhoneAuthCredential phonAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otpControler.text);
                      UserCredential userCredential = await FirebaseAuth
                          .instance.signInWithCredential(phonAuthCredential);
                      User? user = userCredential.user;
                      if (user!.uid.isNotEmpty) {
                        box.write('uid', user.uid);
                        Get.toNamed(usersForm);
                      } else {
                        Fluttertoast.showToast(msg: 'failed');
                      }
                    })
                  ],
                ),
              );
            });
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future googleAuth()async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
  UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
    // Once signed in, return the UserCredential
   User? user =userCredential.user;
   if(user!.uid.isNotEmpty){
     Get.toNamed(usersForm);
   }else{
     return null;
   }
  }
}
