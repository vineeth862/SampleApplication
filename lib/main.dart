import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import 'package:sample_application/src/authentication/auth_validation/authentication_repository.dart';
import 'package:sample_application/src/utils/Provider/selected_test_provider.dart';
import 'src/screens/Home/home.dart';
import 'src/utils/constants/textconstant.dart';
import 'src/utils/themes/themedata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample_application/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SearchListState()),
    ChangeNotifierProvider(create: (_) => SelectedTestState()),
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
      home: const HomePage(
        title: appTitle,
      ),
    );
  }
}
