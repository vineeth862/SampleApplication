import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/firebase_options.dart';
import 'package:sample_application/src/core/Provider/address_provider.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';
import 'package:sample_application/src/core/Provider/selected_order_provider.dart';
import 'package:sample_application/src/core/Provider/selected_test_provider.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/authentication_repository.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'src/core/themes/themedata.dart';
import 'package:get_storage/get_storage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //FlutterNativeSplash.remove();
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SearchListState()),
      ChangeNotifierProvider(create: (_) => SelectedTestState()),
      ChangeNotifierProvider(create: (_) => SelectedOrderState()),
      ChangeNotifierProvider(create: (_) => AppState())
    ], child: SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  storageInit() async {
    await GetStorage.init();
  }

  @override
  Widget build(BuildContext context) {
    storageInit();
    Future.delayed(Duration(seconds: 1), () async {
      await Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform)
          .then((value) => Get.put(AuthenticationRepository()))
          .then((value) => Get.put(UserCurrentLocation()));
    });
    return GetMaterialApp(
        title: 'Sample Application',
        theme: theme,
        themeMode: ThemeMode.light,
        home: AnimatedSplashScreen(
          duration: 5500,
          splash: SvgPicture.asset("assets/images/logo.svg",
              semanticsLabel: 'Medcaph Logo'),
          nextScreen: Container(),
          splashIconSize: double.maxFinite,
          animationDuration: Duration(milliseconds: 2300),
          splashTransition: SplashTransition.scaleTransition,
          // pageTransitionType: PageTransitionType.topToBottomJoined,
          // backgroundColor: Color.fromARGB(255, 255, 240, 223)
        ));
  }
}
