class Category {
  String? title;
  String? path;
  List? testList;
  Category({this.title, this.path, this.testList});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      title: json['title'], path: json['path'], testList: json['testList']);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'title': title, 'path': path, 'testList': testList};
}
