class FoodModel {
  String? name;
  String? id;
  String? categoryId;
  String? cuisineId;
  String? chef;
  String? imagePath;

  FoodModel(
      {this.name,
      this.id,
      this.categoryId,
      this.cuisineId,
      this.chef,
      this.imagePath});

  FoodModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    categoryId = json['categoryId'];
    cuisineId = json['cuisineId'];
    chef = json['chef'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['cuisineId'] = this.cuisineId;
    data['chef'] = this.chef;
    data['image_path'] = this.imagePath;
    return data;
  }
}
