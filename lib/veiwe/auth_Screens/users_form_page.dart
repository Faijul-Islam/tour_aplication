import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tour_aplication/model/const/app_Colors.dart';
import 'package:tour_aplication/model/widget/custom_TextFild.dart';
import 'package:tour_aplication/model/widget/vaioletButton.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../model/helper/from_helper.dart';
import '../routs/routs.dart';

class UsersForm extends StatelessWidget {
  UsersForm({Key? key}) : super(key: key);
  final _nameControler = TextEditingController();
  final _phoneControler = TextEditingController();
  final _addressControler = TextEditingController();
  final Rx<TextEditingController> _dobControler = TextEditingController().obs;
  Rx<DateTime> selectadeDate = DateTime.now().obs;

  String? dob;
  String gender = "Male";
  dateTimepicker(context) async {
    final selectede = await showDatePicker(
        context: context,
        initialDate: selectadeDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (selectede != null && selectede != selectadeDate) {
      dob = "${selectede.day} - ${selectede.month} - ${selectede.year}";
      _dobControler.value.text=dob!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              SizedBox(
                height: 40.h,
              ),
               Text(
                "Tell Us More About You.",
                style: TextStyle(fontSize: 32.sp, color: AppColors.Violet),
              ),
              SizedBox(
                height: 10.h,
              ),
               Text(
                "We will not share your information outside this application.",
                style: TextStyle(fontSize: 16.sp, color: AppColors.Violet),
              ),
              SizedBox(
                height: 50.h,
              ),
              TextFildGlo(
                hintText: "Enter your name",
                controler: _nameControler,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFildGlo(
                hintText: "Enter your phone number",
                controler: _phoneControler,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFildGlo(
                hintText: "Enter your address",
                controler: _addressControler,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => TextField(
                  controller:_dobControler.value ,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => dateTimepicker(context),
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10.h,
              ),
              ToggleSwitch(
                initialLabelIndex: gender == "Male" ? 0 : 1,
                totalSwitches: 2,
                labels: const [
                  'Male',
                  'Female',
                ],
                onToggle: (index) {
                  if (index == 0) {
                    gender = "Male";
                  } else {
                    gender = "Female";
                  }
                  print('switched to: $index');
                },
              ),
              SizedBox(
                height: 142.h,
              ),
              VioletButton(
                  "Submit",
                  ()=>UsersInfo().sendFormDataToDB(
                      _nameControler.text,
                      int.parse(_phoneControler.text),
                      _addressControler.text,
                      dob!,
                      gender)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
