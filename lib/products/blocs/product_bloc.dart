import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/products/blocs/product_state.dart';
import 'package:myapp/products/data/product_repo.dart';
import 'package:myapp/products/data/product_model.dart';

abstract class ProductEvent {}

class ProductTrigerState extends ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final String title;
  final String description;
  final String price;
  final int mainCategoryId;
  final int subCategoryId;
  final List<File> images;

  CreateProductEvent({
    required this.title,
    required this.description,
    required this.price,
    required this.mainCategoryId,
    required this.subCategoryId,
    required this.images,
  });
}

class GetProductsByMainCategoryEvent extends ProductEvent {
  final int mainCategoryId;

  GetProductsByMainCategoryEvent(this.mainCategoryId);
}

class ProductBLoc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo repo;

  ProductBLoc(this.repo) : super(ProductInitialState()) {
    on<ProductTrigerState>(_onGetProducts);
    on<CreateProductEvent>(_onCreateProduct);
    on<GetProductsByMainCategoryEvent>(_onGetProductsByMainCategory);
  }

  void getProducts() {
    add(ProductTrigerState());
  }

  void getProductsByMainCategory(int mainCategoryId) {
    add(GetProductsByMainCategoryEvent(mainCategoryId));
  }

  Future<void> _onGetProducts(
    ProductTrigerState event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      final products = await repo.getProducts();
      emit(ProductLoadedState(products));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      final product = await repo.createProduct(
        title: event.title,
        description: event.description,
        price: event.price,
        mainCategoryId: event.mainCategoryId,
        subCategoryId: event.subCategoryId,
        images: event.images,
      );
      emit(ProductCreatedState(product));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }

  Future<void> _onGetProductsByMainCategory(
    GetProductsByMainCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      final products =
          await repo.getProductsByMainCategory(event.mainCategoryId);
      emit(ProductLoadedState(products));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}
