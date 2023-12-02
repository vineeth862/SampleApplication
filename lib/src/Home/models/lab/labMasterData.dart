class LabMasterData {
  String? type;
  String? title;
  String? path;
  String? labCode;

  LabMasterData({this.type, this.title, this.path, this.labCode});

  factory LabMasterData.fromJson(Map<String, dynamic> json) => LabMasterData(
      type: json['type'],
      title: json['title'],
      path: json['path'],
      labCode: json['labCode']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'title': title,
        'path': path,
        'labCode': labCode
      };
}
