import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class GlobalService {
  final _db = FirebaseFirestore.instance;

  String userInitialAddress = "";
  //String get globalString => _userInitialAddress;
  // set globalString(String newValue) {
  //   _userInitialAddress = newValue;
  // }

  void navigate(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => widget,
      ),
    );
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

  // Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUser() async {
  //   final userKey = getCurrentUserKey();

  //   var user = await _db.collection("user").doc(userKey).get();
  //   print(user);
  //   return user;
  // }

  // static final GlobalService _instance = GlobalService._privateConstructor();

  // GlobalService._privateConstructor();

  // static GlobalService get instance => _instance;

  // String get globalString => userInitialAddress;

  // set globalString(String newValue) {
  //   userInitialAddress = newValue;}
}
