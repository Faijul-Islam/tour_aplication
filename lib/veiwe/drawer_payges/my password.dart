import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tour_aplication/model/widget/custom_textfield.dart';

import '../../model/helper/password_helper.dart';
import '../../model/widget/vaioletButton.dart';

class MyPassword extends StatefulWidget {
  const MyPassword({Key? key}) : super(key: key);

  @override
  State<MyPassword> createState() => _MyPasswordState();
}

class _MyPasswordState extends State<MyPassword> {
  final _idtype = TextEditingController();
  final _idname = TextEditingController();
  final _password = TextEditingController();

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users_password')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('name')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(38.h),
          child: AppBar(
            title: const Text("Password "),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Add your information "),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomTextField(
                                    controller: _idtype,
                                    hintText: "Enter your Id Type",
                                    iconData: Icons.important_devices),
                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomTextField(
                                    controller: _idname,
                                    hintText: "Enter your Id Name",
                                    iconData: Icons.important_devices),
                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomTextField(
                                    controller: _password,
                                    hintText: "Enter your Id Password",
                                    iconData: Icons.important_devices),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.w, right: 30.w),
                                  child: VioletButton("Uploade", () {
                                    UsersStorePassword().sendFormDataToDB(
                                        _idtype.text,
                                        _idname.text,
                                        _password.text);
                                  }),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.add))
            ],
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot == null) {
            return const Center(child: CircularProgressIndicator());
          }else{
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['idName']),
                  subtitle: Text(data['idPassword']),
                );
              }).toList(),
            );
          }

        },
      ),
    );
  }
}
