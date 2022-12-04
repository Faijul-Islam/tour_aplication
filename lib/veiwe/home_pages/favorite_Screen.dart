import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'details_Screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
deletefavorititem(snapshot,i)async{
  FirebaseFirestore.instance
      .collection("Users-Favourite")
      .doc(FirebaseAuth
      .instance.currentUser!.email)
      .collection("items")
      .doc(snapshot.data!.docs[i].id)
      .delete();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
        child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:FirebaseFirestore.instance
              .collection('Users-Favourite')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots() ,
          builder: (_,snapshot){
            if(snapshot.hasError){
             return Text("Error = ${snapshot.error}");
            }
            if(snapshot.hasData){
              final docs=snapshot.data!.docs;
              return Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final data = docs[i].data();
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          InkWell(
                            onTap: () {
                               // Get.to(DetailsScreen(data));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Container(
                                height: 100.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      data['fav-image'],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 25,
                            child: CircleAvatar(
                              child:IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deletefavorititem(snapshot,i);
                                  }),
                            ),
                          )
                        ],
                      );
                    }),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        )
      ),
    );
  }
}
// ListView.builder(
//           itemCount: 10,
//           itemBuilder: (_, index) {
//             return Card(
//               elevation: 3,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 200.h,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage("assets/image/musjid.png"),
//                           fit: BoxFit.cover
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 0,
//                     child: CircleAvatar(
//                       radius: 25.r,
//                       backgroundColor: Colors.white,
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.delete,),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
