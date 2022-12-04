import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFildGlo extends StatelessWidget {
  TextFildGlo({
    Key? key,
    this.suffixIcon,
    required this.hintText,
    required this.controler,
    required this.keyboardType,

    this.obscureText,
    this.labelText,
    this.onTap,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);
  TextEditingController controler;
  TextInputType keyboardType;
  Function?   validator;
  // bool? readOnly;
  VoidCallback? onTap;
  String hintText;
  String? labelText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  final bool ? obscureText;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        //obscureText:obscureText ,
       // readOnly:readOnly ,
       // validator:validator ,
        controller: controler,
        keyboardType: keyboardType,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r,)
          )
        ),
      ),
    );
  }
}
