class ProductImage {
  final int id;
  final String image;
  final bool isPrimary;

  ProductImage({
    required this.id,
    required this.image,
    required this.isPrimary,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      image: json['image'],
      isPrimary: json['is_primary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'is_primary': isPrimary,
    };
  }
}

class Category {
  final int id;
  final String name;
  final String subtitle;
  final String icon;
  final String logoImg;
  final String? mainImg;

  Category({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.logoImg,
    this.mainImg,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      subtitle: json['subtitle'],
      icon: json['icon'],
      logoImg: json['logo_img'],
      mainImg: json['main_img'],
    );
  }
}

class SubCategory {
  final int id;
  final String name;
  final String icon;
  final String subtitle;
  final String logoImg;
  final int mainCategory;

  SubCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.subtitle,
    required this.logoImg,
    required this.mainCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      subtitle: json['subtitle'],
      logoImg: json['logo_img'],
      mainCategory: json['main_category'],
    );
  }
}

class Product {
  final int? id;
  final String title;
  final String description;
  final String price;
  final Category? mainCategory;
  final SubCategory? subCategory;
  final String? createdAt;
  final String? updatedAt;
  final String? user;
  final List<ProductImage>? images;

  // Add getters for UI compatibility
  String get name => title;
  String get imageUrl => images?.isNotEmpty == true ? images!.first.image : '';

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    this.mainCategory,
    this.subCategory,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    print('Parsing product JSON: $json');
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toString() ?? '0',
      mainCategory: json['main_category'] != null
          ? Category.fromJson(json['main_category'])
          : null,
      subCategory: json['sub_category'] != null
          ? SubCategory.fromJson(json['sub_category'])
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'],
      images: json['images'] != null
          ? (json['images'] as List)
              .map((image) => ProductImage.fromJson(image))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'main_category_id': mainCategory?.id,
      'sub_category_id': subCategory?.id,
    };
  }
}
