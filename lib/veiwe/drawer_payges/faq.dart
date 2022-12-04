import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FQAScreen extends StatelessWidget {
   FQAScreen({Key? key}) : super(key: key);
  RxBool _isloded = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:  Expanded(
            child: SfPdfViewer.network(
              "https://firebasestorage.googleapis.com/v0/b/tourapplication-f2135.appspot.com/o/2022_08_10_09-25-08_am.pdf?alt=media&token=e6ab435f-5c39-4a7e-b93a-f12db3d4ede3",
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                _isloded.value = true;
              },
            ),
          ),
        ),
      ),
    );
  }
}
