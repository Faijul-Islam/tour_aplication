import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tour_aplication/model/widget/vaioletButton.dart';

import '../routs/routs.dart';

class PrivicePolicyScreen extends StatelessWidget {
  PrivicePolicyScreen({Key? key}) : super(key: key);
  RxBool _isloded = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SfPdfViewer.network(
                  "https://firebasestorage.googleapis.com/v0/b/tourapplication-f2135.appspot.com/o/2022_08_10_09-25-08_am.pdf?alt=media&token=e6ab435f-5c39-4a7e-b93a-f12db3d4ede3",
                  onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                    _isloded.value = true;
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => _isloded == true
                    ?VioletButton(
                    "Agree",
                    ()=>Get.toNamed(loginScreen)
                ): Text("Still Loading"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
