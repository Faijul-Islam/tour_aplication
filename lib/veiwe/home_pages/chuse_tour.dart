import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoseTure extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('all-data')
      .doc( "faijulislam1@gmail.com")
      .collection("images")
      .snapshots();
  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((e) => {
      'list_images': e['gallery_img'],
      'list_destination': e['destination'],
      'list_cost': e['cost'],
      'list_description': e['description'],
      'list_facilities': e['facilities'],
      'list_owner_name': e['owner_name'],
      'list_phone': e['phone'],
    })
        .toList();
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 100.h,
                                width: 200.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            data['gallery_img'][0]),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data['owner_name']),
                                  Text(data['phone']),
                                  Text(data['cost']),
                                ],
                              )
                            ],
                          ),
                          Text(data['facilities']),
                          Text(data['facilities']),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    ));
  }
}
