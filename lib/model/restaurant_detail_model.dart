class RestaurantDetailModel {
  int? id;
  String? name;
  String? description;
  double? averageRating;

  RestaurantDetailModel({this.id, this.name, this.description, this.averageRating});

  RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    averageRating = json['averageRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['averageRating'] = averageRating;
    return data;
  }

  RestaurantDetailModel copyWith({
    int? id,
    String? name,
    String? description,
    double? averageRating,
  }) {
    return RestaurantDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      averageRating: averageRating ?? this.averageRating,
    );
  }
}
