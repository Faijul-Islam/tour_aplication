import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_aplication/model/widget/text_fild.dart';
import 'package:tour_aplication/model/widget/vaioletButton.dart';

class NavAddLastStep extends StatefulWidget {
  String name;
  String description;
  String cost;
  String facility;
  String destination;
  NavAddLastStep(
      {Key? key,
      required this.facility,
      required this.destination,
      required this.cost,
      required this.description,
      required this.name})
      : super(key: key);

  @override
  State<NavAddLastStep> createState() => _NavAddLastStepState();
}

class _NavAddLastStepState extends State<NavAddLastStep> {
  final _phonControler = TextEditingController();
  final _dateTimeControler = TextEditingController();
  List<XFile>? multipleImages;
  List<String> imageUrls = [];
  final ImagePicker _picker = ImagePicker();
  var authCredential = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;
  Future multipleImagePicker() async {
    multipleImages = await _picker.pickMultiImage();
    setState(() {});
  }

  Future uploadImages() async {
    try {
      if (multipleImages != null) {
          const Center(child: CircularProgressIndicator());
        for (int i = 0; i < multipleImages!.length; i += 1) {
          // upload to stroage
          File imageFile = File(multipleImages![i].path);

          UploadTask uploadTask = storage
              .ref('${authCredential!.email}')
              .child(multipleImages![i].name)
              .putFile(imageFile);
          TaskSnapshot snapshot = await uploadTask;
          String imageUrl = await snapshot.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }

        // upload to database
        uploadToDB();
      } else {
        Fluttertoast.showToast(msg: "Something is wrong.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed");
    }
  }

  uploadToDB() {
    if (imageUrls.isNotEmpty) {
      CollectionReference data =
          FirebaseFirestore.instance.collection("all-data");
      data.doc("faijulislam1@gmail.com").collection('images').doc().set(
        {
          "owner_name": widget.name,
          "description": widget.description,
          "cost": widget.cost,
          "facilities": widget.facility,
          "destination": widget.destination,
          "phone": _phonControler.text,
          "gallery_img": FieldValue.arrayUnion(imageUrls),
        },
      ).whenComplete(
        () => Fluttertoast.showToast(msg: "Uploaded Successfully."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 40.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField('Phone Number', _phonControler),
                customTextField("Destination Date & Time", _dateTimeControler),
                Text(
                  "Choose Images",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EBED),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.r),
                    ),
                  ),
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        multipleImagePicker();
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EBED),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.r),
                    ),
                  ),
                  child: multipleImages?.length == null
                      ? Center(
                          child: Text(
                            "Images are empty",
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.black),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: multipleImages?.length ?? 0,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Container(
                                width: 100.w,
                                child: Image.file(
                                  File(
                                    multipleImages![index].path,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                ),
                SizedBox(
                  height: 50.h,
                ),
                VioletButton("Upload", () {
                  uploadImages();
                  Get.back();
                  _phonControler.clear();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
