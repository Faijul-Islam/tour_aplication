import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tour_aplication/model/const/app_Colors.dart';
import 'package:tour_aplication/model/const/app_String.dart';
import 'package:tour_aplication/model/helper/auth_helper.dart';
import 'package:tour_aplication/model/widget/custom_TextFild.dart';
import 'package:tour_aplication/model/widget/vaioletButton.dart';

import '../routs/routs.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwardControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 80.h),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create \nYour Account",
                    style: TextStyle(
                      color: AppColors.Violet,
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  const Text(
                    "Create your account and start your\n journey",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  TextFildGlo(
                      validator: (email) {
                        if (email!.isEmty) {
                          return const Text("Enter your email");
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email)) {
                          return Fluttertoast.showToast(
                              msg: "Place Enter your valid email");
                        } else {
                          return null;
                        }
                      },
                      hintText: "Enter your E_mail",
                      controler: _emailControler,
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFildGlo(
                      validator: (password) {
                        if (password!.isEmty) {
                          return const Text("Enter your password");
                        }
                        if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(password)) {
                          return Fluttertoast.showToast(
                              msg: "Place Enter your valid password");
                        } else if (password.lenth < 6) {
                          return const Text(
                              "Enter your password character 6-8");
                        } else {
                          return null;
                        }
                      },
                      hintText: "Enter your password",
                      controler: _passwardControler,
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(
                    height: 10.h,
                  ),
                  VioletButton("Create", () {
                    if (_formKey.currentState!.validate()) {
                      return Auth().registration(_emailControler.text,
                          _passwardControler.text, context);
                    }
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Center(child: Text("--OR--")),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {Auth().googleAuth();},
                        icon: const ImageIcon(
                          AssetImage("assets/icons/google.png"),
                          //color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                final phoneContorler = TextEditingController();
                                return AlertDialog(
                                  content: Container(
                                    height: 300.h,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: phoneContorler,
                                        ),
                                        VioletButton("Continue", () {
                                          Auth().singinwithPhone(
                                              phoneContorler.text, context);
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/icons/facebook.png"),
                          // color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Center(
                  //   child: RichText(
                  //     text: TextSpan(
                  //       text: " Already an user? ",
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w300,
                  //       ),
                  //       children: [
                  //         TextSpan(
                  //             text: " Log In",
                  //             style: TextStyle(
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.w300,
                  //                 color: AppColors.Violet),
                  //             recognizer: TapGestureRecognizer()..onTap = () {})
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already an user?  ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(loginScreen);
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.Violet),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
