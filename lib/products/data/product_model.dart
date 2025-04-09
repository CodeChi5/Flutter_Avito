class ProductModel {
  final int id;
  final String name;
  final double price;
  final String description;
  final List<String> imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}
