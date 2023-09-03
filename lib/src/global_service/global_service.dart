import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    String userKey = _auth.currentUser!.phoneNumber.toString();

    return userKey;
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
