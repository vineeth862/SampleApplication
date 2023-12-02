class EventLog {
  String id;
  String module;
  String dateTime;
  dynamic userDetails;
  Map<String, dynamic> metaData;
  String eventType;
  String event;
  EventLog({
    required this.id,
    required this.module,
    required this.dateTime,
    required this.userDetails,
    required this.metaData,
    required this.eventType,
    required this.event,
  });

  factory EventLog.fromJson(Map<String, dynamic> json) => EventLog(
        id: json['id'],
        module: json['module'],
        dateTime: json['dateTime'],
        userDetails: json['userDetails'],
        metaData: json['metaData'],
        eventType: json['eventType'],
        event: json['event'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'module': module,
        'dateTime': dateTime,
        'userDetails': userDetails,
        'metaData': metaData,
        'eventType': eventType,
        'event': event
      };
}
