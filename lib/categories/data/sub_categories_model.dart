import 'dart:convert';

class SubCategoriesModel {
  final int id;
  final String name;
  final String icon;
  final String subtitle;
  final String logoImg;
  final int mainCategory;

  SubCategoriesModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.subtitle,
    required this.logoImg,
    required this.mainCategory,
  });

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SubCategoriesModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      subtitle: json['subtitle'],
      logoImg: json['logo_img'],
      mainCategory: json['main_category'],
    );
  }

  static List<SubCategoriesModel> fromJsonList(String str) {
    final List<dynamic> jsonData = json.decode(str);
    return jsonData.map((item) => SubCategoriesModel.fromJson(item)).toList();
  }
}
