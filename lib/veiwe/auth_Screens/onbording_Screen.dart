import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../model/const/textStyle.dart';
import '../routs/routs.dart';

class OnbordingScreen extends StatelessWidget {
  OnbordingScreen({Key? key}) : super(key: key);


 final RxInt _curentindex = 0.obs;

  List<String> lotifile = [
    "assets/file/welcome.json",
    "assets/file/blue.json",
    "assets/file/animation.json"
  ];
  List<String> title = [
    "Welcome",
    "Categories",
    "Support",
  ];
  List<String> description = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                flex: 2,
                child: Lottie.asset(lotifile[_curentindex.toInt()]),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 1.0,
                        offset: Offset(-4.0, -4.0),
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 1.0,
                        offset: Offset(-4.0, -4.0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            title[_curentindex.toInt()],
                            style: Appstyle().textStyle,
                          ),
                        ),
                        Obx(
                          () => Text(
                            description[_curentindex.toInt()],
                            style: Appstyle().textStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => DotsIndicator(
                                dotsCount: lotifile.length,
                                position: _curentindex.toDouble(),
                                decorator: const DotsDecorator(
                                  activeColor: Colors.deepOrange,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (_curentindex == title.length - 1) {
                                    Get.toNamed(signUp);
                                  } else {
                                    _curentindex + 1;
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
