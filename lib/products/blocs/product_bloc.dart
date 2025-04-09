import '../data/product_model.dart';
import '../data/product_repo.dart';

import 'product_event.dart';
import 'product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBLoc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo repo;
  ProductBLoc(this.repo) : super(ProdcutcalmState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
    });
  }

  @override
  Future<List<ProductModel>> GetProducts(ProductTrigerState event) async {
    print("Im here");
    emit(ProductLoadingState());
    List<ProductModel> list_product = await repo.getProducts();
    await Future.delayed(const Duration(seconds: 5));

    emit(ProductLoadedState(Product_List: list_product));

    return list_product;
  }
}
