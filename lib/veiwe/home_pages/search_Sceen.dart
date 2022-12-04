import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search".tr,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_outlined),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Container(
                          height: 115.h,
                          width: 129.w,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        title: const Text("Title"),
                        subtitle: const Text("Description"),
                        trailing: const Text("Cost"),
                      ),
                    );
                  }
              )
            )
          ],
        ),
      ),
    );
  }
}