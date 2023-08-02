import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalService {
  final _db = FirebaseFirestore.instance;
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
  //   final _auth = FirebaseAuth.instance;

  //   var userKey =
  //       await _db.collection("user").doc(_auth.currentUser!.uid).get();
  //   print(userKey);
  //   return userKey;
  // }
}
