import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_application/src/authentication/models/user.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(Users user) async {
    await _db
        .collection("user")
        .add(user.toJson())
        .whenComplete(() => Get.snackbar("Success", "Yur account is created"))
        .catchError((error, stackTrace) {
      Get.snackbar("Failed", "Something went wrong");
      // print(_db.collection('user').snapshots().length.toString());
    });
  }
}
