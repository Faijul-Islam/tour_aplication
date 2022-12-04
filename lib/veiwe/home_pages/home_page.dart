import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tour_aplication/veiwe/home_pages/add_tour_screen.dart';
import 'package:tour_aplication/veiwe/home_pages/tour_screen.dart';
import 'chuse_tour.dart';
import 'favorite_Screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final RxBool _drawer = false.obs;
  final RxInt _curentIndex = 0.obs;
  final payges = [
    const TourScreen(),
     AddTourScren(),
    const FavoriteScreen(),
     ChoseTure(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedPositioned(
          duration: const Duration(
            microseconds: 500,
          ),
          top: _drawer.value == false ? 0 : 100.h,
          bottom: _drawer.value == false ? 0 : 100.h,
          left: _drawer.value == false ? 0 : 200.w,
          right: _drawer.value == false ? 0 : -100.w,
          child: Container(
            decoration: const BoxDecoration(),
            child: Scaffold(
              appBar: AppBar(
                title:  Text("Shelter".tr),
                leading: _drawer.value == false
                    ? IconButton(
                        onPressed: () {
                          _drawer.value = true;
                        },
                        icon: const Icon(
                          Icons.menu,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          _drawer.value = false;
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
              ),
              body: payges[_curentIndex.value],
              bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: Colors.blueGrey,
                selectedItemColor: Colors.blue,
                onTap: (index) {
                  _curentIndex.value = index;
                },
                currentIndex: _curentIndex.value,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favorite"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.tour_outlined), label: "Chose tour"),
                ],
              ),
            ),
          ),
        ));
  }
}
