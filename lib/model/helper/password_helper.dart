import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../veiwe/routs/routs.dart';

class UsersStorePassword{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  sendFormDataToDB(
      String idType, String idName, String idPassword) async {
    try {
      CollectionReference _password =
      FirebaseFirestore.instance.collection("users_password");
      _password.doc(_auth.currentUser!.email).collection('name').doc().set({
        'id Type': idType,
        'idName': idName,
        'idPassword': idPassword,
      }).whenComplete(
            () {
          Fluttertoast.showToast(msg: "Added Successfully");
          Get.toNamed(myPassword);
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "error: $e");
    }
  }

}