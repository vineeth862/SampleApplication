import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalService {
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

  String getCurrentUser() {
    final _auth = FirebaseAuth.instance;

    String userKey = _auth.currentUser!.phoneNumber.toString();

    return userKey;
  }
}
