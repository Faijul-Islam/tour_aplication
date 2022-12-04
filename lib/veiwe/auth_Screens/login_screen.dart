import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tour_aplication/model/helper/auth_helper.dart';

import '../../model/const/app_Colors.dart';
import '../../model/widget/custom_TextFild.dart';
import '../../model/widget/vaioletButton.dart';
import '../routs/routs.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 80.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login \nto Your Account",
                    style: TextStyle(
                      color: AppColors.Violet,
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
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
                          return Fluttertoast.showToast(
                              msg: "Place Enter your  password character 6-8");
                          const Text("Enter your password character 6-8");
                        } else {
                          return null;
                        }
                      },
                      hintText: "Enter your password",
                      controler: _passwordControler,
                      keyboardType: TextInputType.visiblePassword),
                  SizedBox(
                    height: 10.h,
                  ),
                  VioletButton("Login", () {
                    if (_formKey.currentState!.validate()) {
                      return Auth().login(_emailControler.text,
                          _passwordControler.text, context);
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
                        onPressed: () {},
                        icon: const ImageIcon(
                          AssetImage("assets/icons/google.png"),
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const ImageIcon(
                          AssetImage("assets/icons/facebook.png"),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "I don't have an account?  ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(signUp);
                        },
                        child: const Text(
                          "Sing Up",
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
