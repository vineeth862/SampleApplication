import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  final storage = FirebaseStorage.instance.ref();

  Future<String> getImageRef(refPath) async {
    return await storage.child(refPath).getDownloadURL();
  }
}
