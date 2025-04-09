import 'package:equatable/equatable.dart';

import '../data/product_model.dart';

abstract class ProductState extends Equatable {}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProdcutcalmState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductTrigerState extends ProductState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ProductLoadedState extends ProductState {
  List<ProductModel> Product_List;
  ProductLoadedState({required this.Product_List});

  @override
  List<Object?> get props => [];
}
