import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyScreen extends StatelessWidget {
   PrivacyScreen({Key? key}) : super(key: key);
  RxBool _isloded = false.obs;
  pdfloded(data){
    return SfPdfViewer.network(
      data["url"],
      onDocumentLoaded: (PdfDocumentLoadedDetails details) {
        _isloded.value = true;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child:  Expanded(
            child:StreamBuilder(
              stream: FirebaseFirestore.instance.collection("privacy").doc("1") .snapshots(),
                builder: (context,snapshots){
                var data=snapshots.data;
                if(!snapshots.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else if(snapshots.hasError){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  return pdfloded(data);
                }
                }
            ),
          ),
        ),
      ),
    );
  }
}
