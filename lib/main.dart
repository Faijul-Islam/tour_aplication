
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tour_aplication/const/app_thime.dart';
import 'package:tour_aplication/language/language.dart';
import 'package:tour_aplication/model/const/app_String.dart';
import 'package:tour_aplication/notificationservice/notificationservice.dart';
import 'package:get/get.dart';
import 'package:tour_aplication/veiwe/routs/routs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main()async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  LocalNotificationService.initialize();

  //====== disable landscape mode ======
  //------------------------------------
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //========= This portion contains status bar and ===========
  //========= navigation bar settings ========================
  //----------------------------------------------------------
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
    runApp( App());


}
class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    name: "Shelter",
    options: const FirebaseOptions(
        apiKey: "AIzaSyA_qD5qG3v4DXhvlFGnWlyNUo1DdlqI2q0",
        appId: "1:258772877003:android:f567e962036adde5d1e54e",
        messagingSenderId: "258772877003",
        projectId: "tourapplication-f2135"),
  );

   App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);
   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child){
          return    GetMaterialApp(
            translations: Language(),
            locale: const Locale("en","US"),
            fallbackLocale:const Locale("en","US"),
            title: AppString.appName,
            themeMode: ThemeMode.system,
             darkTheme: AppTheme().darkTheme(context),
             theme: AppTheme().lightTheme(context),
            debugShowCheckedModeBanner: false,
            initialRoute: splash,
            getPages: payges,
            //home:  const SplashScreen(),
          );
        }
    );
  }

}
