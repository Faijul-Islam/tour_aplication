import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tour_aplication/model/const/textStyle.dart';

Widget drawerItem(itemName, onTap) {
  return InkWell(
    onTap: onTap,
    child: Text(
      itemName,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
    ),
  );
}
