import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class dbOperationsService extends GetxController {
  static dbOperationsService get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  void loadDataList(jsonList, collection, id) async {
    for (int i = 0; i < jsonList.length; i++) {
      bool result = await load(jsonList[i], collection, id);
    }
  }

  bool load(obj, collection, id) {
    if (id != null && id.toString().trim().length > 0) {
      obj[id] = obj[id].toString();
      _db
          .collection(collection)
          .doc(obj[id])
          .set(obj)
          .whenComplete(() => Get.snackbar("Success", "data getting added"))
          .catchError((error, stackTrace) {
        Get.snackbar("Failed", error);
      });
    } else {
      _db
          .collection(collection)
          .doc()
          .set(obj)
          .whenComplete(() => Get.snackbar("Success", "data getting added"))
          .catchError((error, stackTrace) {});
    }

    return true;
  }
}
