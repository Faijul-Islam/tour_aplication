import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tour_aplication/model/widget/text_fild.dart';
import '../../model/widget/vaioletButton.dart';

class Test extends StatelessWidget {
  final TextEditingController nameControler = TextEditingController();
  final TextEditingController _phoneControler = TextEditingController();
  final TextEditingController addressControler = TextEditingController();
  final Rx<TextEditingController> _dobControler = TextEditingController().obs;
  Rx<DateTime> selectadeDate = DateTime.now().obs;
  String? dob;
  String gender = "Male";
  dateTimepicker(context) async {
    final _selectDate = await showDatePicker(
      context: context,
      initialDate: selectadeDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (_selectDate != null && _selectDate != selectadeDate) {
      dob= '${_selectDate.day}-${_selectDate.month}-${_selectDate.year}';
      _dobControler.value.text =dob!;

    }
  }

  setData(_data, context) {
    nameControler.text = _data['name'];
    _phoneControler.text = _data['phone'].toString();
    addressControler.text = _data['address'];
    _dobControler.value.text = _data['dob'];
    gender = _data['gender'];
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            InkWell(
              onTap: (){},
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 80.r,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(radius: 75.r,
                    ),
                  ),
                ),
              ),
            ),
            customTextField("Enter your name", nameControler),
            customTextField("Enter your phone", _phoneControler),
            customTextField("Enter your Address", addressControler),
            Obx(() => TextFormField(
              controller:_dobControler.value ,
                  readOnly: true,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          dateTimepicker(context);
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                      hintText: "Enter your date of birth"),
                )),
            ToggleSwitch(
              initialLabelIndex: gender=="Male"?0:1,
              totalSwitches: 2,
              labels: const ['Male', 'Female'],
              onToggle: (index) {
                if (index == 0) {
                  gender = "Male";
                } else {
                  gender = "Female";
                }
                print('switched to: $index');
              },
            ),
           VioletButton("UpDate", (){
             updateData();
           })
          ],
        ),
      ),
    );
  }
  updateData()async{
    try{
      CollectionReference _reference=FirebaseFirestore.instance.collection("users-form-data");
      final user=FirebaseAuth.instance.currentUser!.email;
      _reference.doc(user).update({
        "name": nameControler.text,
        "phone": _phoneControler.text,
        "address": addressControler.text,
        "dob": _dobControler.value.text,
        "gender": gender,
      }).then((value) {
        Fluttertoast.showToast(msg: "Updated Successfully");
        Get.back();
      });
    }catch(e){
      Fluttertoast.showToast(msg: "Updated Successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-form-data")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (_, snapshote) {
            var _data = snapshote.data;
            if (snapshote.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshote.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return setData(_data, context);
            }
          },
        ),
      ),
    );
  }
}
