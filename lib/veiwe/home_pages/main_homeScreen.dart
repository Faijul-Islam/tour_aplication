import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tour_aplication/veiwe/home_pages/home_page.dart';
import '../../notificationservice/notificationservice.dart';
import '../routs/routs.dart';
import 'drawer_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  Future _exitDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Are u sure to close this app?"),
            content: Row(
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("No"),
                ),
                SizedBox(
                  width: 20.w,
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text("Yes"),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['_id'] != null) {
           Get.toNamed(mainhomeScreen);
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
  }

  String deviceTokenToSendPushNotification = "";
  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
    FirebaseFirestore.instance
        .collection("token")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({"idtoken": deviceTokenToSendPushNotification});
  }

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();
    return WillPopScope(
      onWillPop: () {
        _exitDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            const DrawerScreen(),
            HomePage(),
          ],
        ),
      ),
    );
  }
}
//    FirebaseMessaging.onMessage.listen(( message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification!.title}');
//         print('Message also contained a notification: ${message.notification!.body}');
//       }
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen(( message) {
//       if (message.notification != null) {
//         print(message.notification!.title);
//         print(message.notification!.body);
//         print(message.data['path']);
//       }
//     });
