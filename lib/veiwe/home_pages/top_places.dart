import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopPlaces extends StatelessWidget {
  const TopPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Places"),
        backgroundColor: Colors.deepPurple,
      ),
      body: GridView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (BuildContext context,index){
            return Container(
              width: 164.w,
              height: 219.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }
      ),
    );
  }
}
