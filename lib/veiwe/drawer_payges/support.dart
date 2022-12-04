import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tour_aplication/model/widget/text_fild.dart';

class SupportScreen extends StatelessWidget {
   SupportScreen({Key? key}) : super(key: key);
  final TextEditingController _phoneControler = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _facebookControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("If you have any problems , please contact us . We are at your service all the time."),
            SizedBox(height: 10.h,),
            Text("phone number"),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40),
              child: customTextField(
                  "01764474873",
                  _phoneControler
              ),
            ),
            Text("Email Address"),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40),
              child: customTextField(
                  "mdfaijulislam353@gmail.com",
                  _emailControler
              ),
            ),
             Text("Facebook"),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,),
              child: customTextField(
                  "fb/afransarkar11",
                  _facebookControler
              ),
            ),
          ],
        ),
      ),
    );
  }
}
