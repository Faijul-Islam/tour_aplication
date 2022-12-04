import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  ThemeData lightTheme(context)=>ThemeData(
    appBarTheme:  AppBarTheme(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.w700,)
    ),
    primaryColor: Colors.purple,
    brightness:Brightness.light ,
    primarySwatch: Colors.blue,
    textTheme: GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme.apply(bodyColor: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),

  );
  ThemeData darkTheme(context)=>ThemeData(
    primaryColor: Colors.purple,
    brightness:Brightness.dark ,
  //  buttonColor: Colors.deepPurple,
    primarySwatch: Colors.amber,
    textTheme: GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme.apply(bodyColor: Colors.white),
    ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(primary: Colors.white),
    appBarTheme:  AppBarTheme(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.w700,)
    ),
  );
}