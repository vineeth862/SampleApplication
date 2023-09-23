import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_application/src/screens/Home/models/user/address.dart';
import 'package:sample_application/src/screens/Home/models/user/user.dart';
import 'package:sample_application/src/global_service/global_service.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  GlobalService globalservice = GlobalService();
  createUser(User user) async {
    DocumentSnapshot userPresent =
        await _db.collection("user").doc(user.mobile).get();

    if (!userPresent.exists) {
      await _db
          .collection("user")
          .doc(user.mobile)
          .set(user.toJson())
          .whenComplete(
              () => Get.snackbar("Success", "Your account is created"))
          .catchError((error, stackTrace) {
        print(error);
        Get.snackbar("Failed", "Something went wrong");
        // print(_db.collection('user').snapshots().length.toString());
      });
    }
  }

  updateUser(User user, String oldUserKey) async {
    //print(oldUserKey);
    final oldDocumentRef = _db.collection("user").doc(oldUserKey);
    oldDocumentRef.update({"mobile": user.mobile});
    //print(oldDocumentRef);
    final oldDocumentSnapshot = await oldDocumentRef.get();
    //print(oldDocumentSnapshot);
    final data = oldDocumentSnapshot.data();
    data?['locations'];

    //print(user.mobile);

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

  getOrderIds() async {
    String userKey = globalservice.getCurrentUserKey();
    var user = await _db.collection("user").doc(userKey).get();

    if (user.data()?['orders'] != null) {
      return user.data()?['orders'] as List;
    } else {
      return [] as List;
    }
  }

  addOrderIdsToUser(orderId) async {
    String userKey = globalservice.getCurrentUserKey();

    List orders = await this.getOrderIds();
    if (orders.where((order) => order == orderId).length == 0) {
      orders.add(orderId);
    }

    //need to change this
    await _db
        .collection("user")
        .doc(userKey)
        .set({"orders": orders}, SetOptions(merge: true))
        .whenComplete(() => print("order added to user"))
        .catchError((error, stackTrace) {
          print("Something went wrong");
        });
    return true;
  }

  getUser() async {
    String userKey = globalservice.getCurrentUserKey();
    final data = await _db.collection("user").doc(userKey).get();
    return data;
  }

  updateAdress(address addressObj) async {
    String userKey = globalservice.getCurrentUserKey();
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
    String userKey = globalservice.getCurrentUserKey();
    final data = await _db.collection("user").doc(userKey).get();

    List<dynamic> locationArray = data.data()?['locations'];

    if (locationArray != null && locationArray is List) {
      List<Map<String, dynamic>> locationList =
          List<Map<String, dynamic>>.from(locationArray);

      return locationList;
    } else {
      print("Document does not exist.");
    }
  }

  deleteAddress(index) async {
    String userKey = globalservice.getCurrentUserKey();

    final data = await _db.collection("user").doc(userKey).get();
    List<dynamic> locationArray = data.data()?['locations'];

    locationArray.removeAt(index);
    _db.collection("user").doc(userKey).update({"locations": locationArray});
  }

  Future<User> getUserData() async {
    String userKey = globalservice.getCurrentUserKey();

    final _db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> userdata =
        await _db.collection("user").doc(userKey).get();

    return User.fromJson(userdata.data() as Map<String, dynamic>);
  }
}
