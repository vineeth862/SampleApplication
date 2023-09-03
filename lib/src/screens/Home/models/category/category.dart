class Category {
  String? type;
  String? title;
  String? path;

  Category({this.type, this.title, this.path});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(type: json['type'], title: json['title'], path: json['path']);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'type': type, 'title': title, 'path': path};
}
