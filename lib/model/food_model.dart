class FoodModel {
  String? label;
  String? image;
  String? url;

  FoodModel({this.label, this.image, this.url});

  FoodModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}
