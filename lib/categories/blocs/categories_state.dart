import 'package:equatable/equatable.dart';
import 'package:myapp/categories/data/categories_model.dart';
import 'package:myapp/categories/data/sub_categories_model.dart';

abstract class CategoriesState extends Equatable {}

abstract class CategoriesReseachState extends Equatable {}

abstract class SubCategoriesState extends Equatable {}

class CategoriesLoadingState extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class ProdcutcalmState extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class CategoriesTrigerState extends CategoriesState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class CategoriesLoadedState extends CategoriesState {
  List<CategoriesModel> Categories_List;
  CategoriesLoadedState({required this.Categories_List});

  @override
  List<Object?> get props => [];
}

class CategoriesReseachLoadingState extends CategoriesReseachState {
  @override
  List<Object?> get props => [];
}

class CategoriesReseachTrigerState extends CategoriesReseachState {
  @override
  List<Object?> get props => [];
}

class CategoriesReseachcalmState extends CategoriesReseachState {
  @override
  List<Object?> get props => [];
}

class CategoriesReseachLoadedState extends CategoriesReseachState {
  List<CategoriesModel> Categories_List;
  CategoriesReseachLoadedState({required this.Categories_List});

  @override
  List<Object?> get props => [];
}

class SubCategoriescalmState extends SubCategoriesState {
  @override
  List<Object?> get props => [];
}

class SubCategoriesLoadingState extends SubCategoriesState {
  @override
  List<Object?> get props => [];
}

class SubCategoriesLoadedState extends SubCategoriesState {
  List<SubCategoriesModel> Categories_List;
  SubCategoriesLoadedState({required this.Categories_List});
  @override
  List<Object?> get props => [];
}

class SubCategoriesTrigerState extends SubCategoriesState {
  final String id;

  SubCategoriesTrigerState({required this.id});

  @override
  List<Object?> get props => [id];
}
