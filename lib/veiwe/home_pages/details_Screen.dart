import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  Map detailsData;
  DetailsScreen(this.detailsData, {Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final RxInt _currentIndex = 0.obs;
  final List<String> _carouselImages = [];
  fachCarosulImages() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('carosul_images').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(qn.docs[i]['img']);
        print(qn.docs[i]['img']);
      }
    });
    return qn.docs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> checkFav(
      BuildContext context) async* {
    yield* FirebaseFirestore.instance
        .collection("Users-Favourite")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .where("fav-image", isEqualTo: widget.detailsData['list_images'][0])
        .snapshots();
  }

  addtoFavourite() async {
    FirebaseFirestore.instance
        .collection('Users-Favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .doc()
        .set(
      {
        'fav-image': widget.detailsData['list_images'][0],
        'fav-destination': widget.detailsData['list_destination'],
        'fa-cost': widget.detailsData['list_cost'],
      },
    ).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Added to favourite",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white,
          fontSize: 13.0);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    fachCarosulImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "details".tr,
          style: TextStyle(fontSize: 20.sp, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: checkFav(context),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const Text("  bvnhgndfcZx");
              return IconButton(
                icon: snapshot.data!.docs.isEmpty
                    ? const Icon(
                        Icons.favorite_outline,
                      )
                    : const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                onPressed: () {
                  snapshot.data!.docs.isEmpty
                      ? addtoFavourite()
                      : Fluttertoast.showToast(
                          msg: "Already Added",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepOrange,
                          textColor: Colors.white,
                          fontSize: 13.0);
                },
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                        aspectRatio: 2,
                        child: Image.network(
                          widget.detailsData['list_images'][0],
                          fit: BoxFit.cover,
                        )),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.detailsData['list_description'],
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "Facilities",
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.detailsData['list_facilities'],
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "Destination",
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.detailsData['list_destination'],
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            "Cost",
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.detailsData['list_cost']} Tk",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.detailsData['list_owner_name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  "tel:${widget.detailsData['list_phone']}"));
                            },
                            icon: const Icon(Icons.call_outlined)),
                        IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  "sms:${widget.detailsData['list_phone']}"));
                            },
                            icon: const Icon(Icons.message_outlined)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
