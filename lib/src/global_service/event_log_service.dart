import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_application/src/screens/Home/models/event-logs/event-logs.dart';

class EventLogService {
  final _db = FirebaseFirestore.instance;

  addLog(EventLog event) async {
    final document = await _db.collection("eventlogs").doc();
    event.id = document.id;
    await _db
        .collection("eventlogs")
        .doc(event.id)
        .set(event.toJson())
        .whenComplete(() => print("succes"))
        .catchError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
