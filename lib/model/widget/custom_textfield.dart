import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// this class refers a custom textField widget
/// it is to re use a common pattern of textField
/// it takes [TextEditingController] , [hintText] and [IconData] as required
/// and [TextInputType], [secure] as optional parameters.

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool secure;
  final String hintText;
  final IconData iconData;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.textInputType = TextInputType.text,
    required this.hintText,
    this.secure = false,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38.h,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.withOpacity(.1.sp),
              width: 1.1.sp,
            ),
          ),
          padding: EdgeInsets.only(left: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color:Colors.grey.withOpacity(.5),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: TextField(
                    controller: controller,
                    obscureText: secure,
                    keyboardType: textInputType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(fontSize: 12.sp, color:Colors.grey,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
