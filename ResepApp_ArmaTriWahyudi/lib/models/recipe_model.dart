class RecipeModel {
  int? id;
  String? title;
  String? image;
  String? summary;

  RecipeModel({this.id, this.title, this.image, this.summary});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['summary'] = summary;
    return data;
  }
}
