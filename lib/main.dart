import 'package:flutter/material.dart';
import 'package:sample_application/src/utils/constants/constant.dart';
import 'package:sample_application/src/utils/themes/themedata.dart';
import 'package:sample_application/src/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const HomePage(
        title: appTitle,
      ),
    );
  }
}
