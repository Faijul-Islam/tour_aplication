import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tour_aplication/veiwe/home_pages/test.dart';
import '../../model/widget/custom_TextFild.dart';
import '../../model/widget/vaioletButton.dart';
import 'package:image_picker/image_picker.dart';

import 'Search_Screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameControler = TextEditingController();

  final _phoneControler = TextEditingController();

  final _addressControler = TextEditingController();

  final Rx<TextEditingController> _dobControler = TextEditingController().obs;

  Rx<DateTime> selectadeDate = DateTime.now().obs;

  String? dob;

  String gender = "Male";

  dateTimepicker(context) async {
    final _selectede = await showDatePicker(
        context: context,
        initialDate: selectadeDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (_selectede != null && _selectede != selectadeDate) {
      dob = "${_selectede.day} - ${_selectede.month} - ${_selectede.year}";
      _dobControler.value.text = dob!;
    }
  }

  setUserData(data, context) {
    _nameControler.text = data['name'];
    _phoneControler.text = data['phone'].toString();
    _addressControler.text = data['address'];
    _dobControler.value.text = data['dob'];
    gender = data['gender'];
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Test()));
              },
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 80.r,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 75.r,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            TextFildGlo(
              hintText: "Enter your name",
              controler: _nameControler,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFildGlo(
              hintText: "Enter your phone number",
              controler: _phoneControler,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFildGlo(
              hintText: "Enter your address",
              controler: _addressControler,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => TextFormField(
                controller: _dobControler.value,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "date of birth",
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => dateTimepicker(context),
                    icon: const Icon(Icons.calendar_month_rounded),
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
              height: 20.h,
            ),
            VioletButton("update".tr, () => updateData(data)),
          ],
        ),
      ),
    );
  }

  updateData(data) {
    try {
      CollectionReference registerData =
          FirebaseFirestore.instance.collection("users-form-data");
      final user = FirebaseAuth.instance.currentUser!.email;
      registerData
          .doc(user)
          .update({
            "name": _nameControler.text,
            "phone": _phoneControler.text,
            "address": _addressControler.text,
            "dob": _dobControler.value.text,
            "gender": gender,
          })
          .then(
            (value) => Fluttertoast.showToast(
                msg: "Updated Successfully", backgroundColor: Colors.black87),
          )
          .then(
            (value) => Get.back(),
          );
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something is wrong", backgroundColor: Colors.black87);
    }
  }

  final _picker = ImagePicker();
  var authCredential = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  List<XFile>? multipleImages;
  List<String> imageUrls = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-form-data")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return setUserData(data, context);
            //setUserData(data, context);
          },
        ),
      )),
    );
  }
}
