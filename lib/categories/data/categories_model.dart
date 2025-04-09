import 'dart:convert';

class CategoriesModel {
  final int id;
  final String name;
  final String imageUrl;
  final String icon;
  final String subtitle;
  final String mainImg;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.icon,
    required this.subtitle,
    required this.mainImg,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      subtitle: json['subtitle'],
      icon: json['icon'],
      imageUrl: json['logo_img'],
      mainImg: json['main_img'],
    );
  }

  static List<CategoriesModel> fromJsonList(String str) {
    final List<dynamic> jsonData = json.decode(str);
    return jsonData.map((item) => CategoriesModel.fromJson(item)).toList();
  }
}
