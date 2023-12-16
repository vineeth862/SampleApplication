import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:convert';
import 'package:flutter/services.dart';

import '../helper_widgets/loader.dart';

class GlobalService {
  final _db = FirebaseFirestore.instance;

  String userInitialAddress = "";
  //String get globalString => _userInitialAddress;
  // set globalString(String newValue) {
  //   _userInitialAddress = newValue;
  // }

  void navigate(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return widget;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastEaseInToSlowEaseOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
          // var fadeAnimation =
          //     Tween<double>(begin: 0.0, end: 1.0)
          //         .animate(animation);

          // return FadeTransition(
          //   opacity: fadeAnimation,
          //   child: SlideTransition(
          //     position: offsetAnimation,
          //     child: child,
          //   ),
          // );
        },
      ),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (ctx) => widget,
    //   ),
    // );
  }

  String listToComaSeparateString(List<String> list, String match) {
    return list
            .where((element) =>
                element.contains(match.trim()) || match.trim().isEmpty)
            .join(",")
            .isNotEmpty
        ? " - " +
            list
                .where((element) =>
                    element.contains(match.trim()) || match.trim().isEmpty)
                .join(",")
        : "";
  }

  String getCurrentUserKey() {
    final _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      String userKey = _auth.currentUser!.phoneNumber.toString();
      return userKey;
    } else {
      return "null";
    }
  }

  makingPhoneCall(phone) async {
    UrlLauncher.launch("tel://" + phone);
  }

  sendSMS(phone, content) {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phone,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent(content),
      },
    );
    UrlLauncher.launchUrl(smsLaunchUri);
  }

  sendEmail(emai, subject, content) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emai,
      query: encodeQueryParameters(
          <String, String>{'subject': subject, 'body': content}),
    );
    UrlLauncher.launchUrl(emailLaunchUri);
    // UrlLauncher.launch('mailto:${p.email}');
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Uint8List getImageByteCode(data) {
    Uint8List bytes = base64.decode(data.split(',').last);

    return bytes;
  }

  showLoader() {
    Get.to(() => LoaderScreen());
  }

  hideLoader() async {
    Future.delayed(Duration(seconds: 1), () {
      Get.back();
    });
  }

  getLength(list) {
    if (list == null) return 0;

    return list.length;
  }

  getString(obj) {
    if (obj == null) return "";
    return obj;
  }
}
