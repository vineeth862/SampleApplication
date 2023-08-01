import 'dart:io';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_application/src/authentication/models/address.dart';
import 'package:sample_application/src/authentication/models/user.dart';
import 'package:sample_application/src/global_service/global_service.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  GlobalService globalservice = GlobalService();
  createUser(Users user) async {
    await _db
        .collection("user")
        .doc(user.mobile)
        .set(user.toJson())
        .whenComplete(() => Get.snackbar("Success", "Your account is created"))
        .catchError((error, stackTrace) {
      Get.snackbar("Failed", "Something went wrong");
      // print(_db.collection('user').snapshots().length.toString());
    });
  }

  updateUser(Users user, String oldUserKey) async {
    print(oldUserKey);
    final oldDocumentRef = _db.collection("user").doc(oldUserKey);
    oldDocumentRef.update({"mobile": user.mobile});
    print(oldDocumentRef);
    final oldDocumentSnapshot = await oldDocumentRef.get();
    print(oldDocumentSnapshot);
    final data = oldDocumentSnapshot.data();
    data?['locations'];

    print(user.mobile);

    final newDocumentRef = _db.collection("user").doc(user.mobile);
    await newDocumentRef
        .set(data!)
        .whenComplete(() =>
            Get.snackbar("Success", "Your Mobile Number Changed Successfully"))
        .catchError((error, stackTrace) {
      Get.snackbar("Failed", "Something went wrong");
    });

    // Step 3: Delete the old document (optional)
    await oldDocumentRef.delete();
  }

  updateAdress(address addressObj) async {
    String userKey = globalservice.getCurrentUser();
    await _db
        .collection("user")
        .doc(userKey) //need to change this
        .set({
          "locations": FieldValue.arrayUnion(
            [
              {
                "fullAddress": addressObj.fullAddress,
                "pincode": addressObj.pincode,
                "floorNumber": addressObj.floorNumber,
                "houseNumber": addressObj.houseNumber
              }
            ],
          )
        }, SetOptions(merge: true))
        .whenComplete(
            () => Get.snackbar("Success", "Your Address is Added Successfully"))
        .catchError((error, stackTrace) {
          Get.snackbar("Failed", "Something went wrong");
        });
  }

  getAdress() async {
    String userKey = globalservice.getCurrentUser();
    final data = await _db.collection("user").doc(userKey).get();
    //print(data.data()?.containsKey("locations"));
    //print(data.data()?['locations']);
    List<dynamic> locationArray = data.data()?['locations'];
    //print(locationArray);
    if (locationArray != null && locationArray is List) {
      // Assign the type List<Map<String, dynamic>> to the array
      List<Map<String, dynamic>> locationList =
          List<Map<String, dynamic>>.from(locationArray);
      //print(locationList.runtimeType);
      return locationList;
    } else {
      print("Document does not exist.");
    }
    //return items1;
  }

  deleteAddress(index) async {
    String userKey = globalservice.getCurrentUser();

    final data = await _db.collection("user").doc(userKey).get();
    List<dynamic> locationArray = data.data()?['locations'];

    locationArray.removeAt(index);
    _db.collection("user").doc(userKey).update({"locations": locationArray});
  }

  Future<Map<String, dynamic>> getUserData() async {
    String userKey = globalservice.getCurrentUser();
    Map<String, dynamic> data = {};
    final _db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> userdata =
        await _db.collection("user").doc(userKey).get();
    data['userName'] = userdata.data()?['userName'];
    data['email'] = userdata.data()?['email'];
    data['gender'] = userdata.data()?['gender'];
    String mobile = userdata.data()?['mobile'];
    data['mobile'] = mobile.substring(3);
    // data.add(userdata.data()?['userName']);
    // data.add(userdata.data()?['email']);
    // data.add(userKey);
    print(data);
    return data;
  }
}
