import 'package:myapp/products/data/product_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> Product_List;

  ProductLoadedState(this.Product_List);
}

class ProductCreatedState extends ProductState {
  final Product product;

  ProductCreatedState(this.product);
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState(this.error);
}
