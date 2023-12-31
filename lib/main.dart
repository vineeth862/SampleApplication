import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/globalServices/userAdress/locatonService.dart';
import 'package:sample_application/src/core/spalsh_screen/splashscreen.dart';
import 'package:sample_application/src/core/Provider/address_provider.dart';
import 'package:sample_application/src/core/Provider/loading_provider.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/authentication_repository.dart';
import 'package:sample_application/src/core/Provider/selected_order_provider.dart';
import 'package:sample_application/src/core/Provider/selected_test_provider.dart';
import 'src/core/themes/themedata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample_application/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()))
      .then((value) => Get.put(UserCurrentLocation()));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SearchListState()),
    ChangeNotifierProvider(create: (_) => SelectedTestState()),
    ChangeNotifierProvider(create: (_) => SelectedOrderState()),
    ChangeNotifierProvider(create: (_) => AppState()),
    ChangeNotifierProvider(create: (_) => LoadingProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return GetMaterialApp(
      title: 'Sample Application',
      theme: theme,
      themeMode: ThemeMode.light,
      home: const MySplashScreen(),
    );
  }
}
