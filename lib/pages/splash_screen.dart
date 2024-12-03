import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wazker/pages/home_screen.dart';
import 'package:wazker/pages/subCategory.dart';

import '../../core/size_config.dart';
import '../controllers/azkar_controller.dart';
import '../translation/translation_page.dart';
import 'actions/actions_predefine.dart';
import 'actions/database_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final HomePageController homePageController = Get.put(HomePageController());
  final AzkarController azkarController = Get.put(AzkarController());
  String? mytoken;
  bool _isSkipped = false;

  @override
  void initState() {
    // getToken();
    // _checkSkipStatus();
    // // Request permission
    // requestPermission();

    super.initState();
  }

//   void requestPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }

//   void _checkSkipStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _isSkipped = prefs.getBool('isSkipped') ?? false;
//     if (!_isSkipped) {
//       Timer(Duration(seconds: 1), () {
//         setState(() {
//           _isSkipped = true;
//         });
//       });
//     }
//   }

// // get FCM firebase token it should be fixed for login within the same device
//   getToken() async {
//     mytoken = await FirebaseMessaging.instance.getToken();
//     //mytoken = 'await FirebaseMessaging.instance.getToken();';
//     setState(() {
//       currentUserController.currentUser.value.accountToken = mytoken!;
//       mytoken = mytoken;
//       print(mytoken);
//     });

//     // Assuming you have a variable named 'currentUserController' and it has a user
//     // whose ID you want to check in the Firestore collection
//     String userId = currentUserController.currentUser.value.id.toString();

//     // Get a reference to the document
//     DocumentReference docRef =
//         FirebaseFirestore.instance.collection('users').doc(userId);

//     // Use get() to retrieve the document
//     DocumentSnapshot docSnapshot = await docRef.get();

//     // Check if the document exists
//     if (docSnapshot.exists) {
//       currentUserController.currentUser.value.incomeMessage = true;
//       print('Document exists!');
//       // The document exists, you can access its data using docSnapshot.data()
//     }
//   }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSplashScreen.withScreenFunction(
        animationDuration: const Duration(milliseconds: 500),
        splashIconSize: sp(150),
        //duration: 2,

        splash: Container(
          width: w(45),
          height: h(70),
          child: Image.asset(
            "assets/images/logo/logo.png",

            fit: BoxFit.cover,
            // width: w(30),
            // height: h(70),
            //color: Colors.red,
          ),
        ),
        screenFunction: () async {
          // bool isOnline = await hasNetwork();
          // if (isOnline) {
          // unlockController.getlist();
          // categoryController.getdata();
          SharedPreferences prefs = await SharedPreferences.getInstance();

          var _lang = prefs.getString('lang');

          try {
            azkarController.selectedLanguage.value = _lang!;
            azkarController.getAzkarList();

            // homePageController.getHomePageData();
            // currentUserController.currentUser.value =
            //     await loadUserData('user');

            //cartController.getcartList();

            var locale = Locale(_lang!, _lang);
            Get.updateLocale(locale);
          } catch (e) {
            print(e);
            // removeUserData('user');
          }
          if (_lang == "ar" || _lang == "en") {
            return SubCategoryPage();
          } else {
            return TrnaslationPage();
          }
          // } else {
          //   return NoConnectionPage();
          // }
        },
        splashTransition: SplashTransition.scaleTransition,
        //pageTransitionType: ,
        // backgroundColor: Colors.black,
      ),
    );
  }
}
