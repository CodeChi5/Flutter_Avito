import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {}

class LoadCategoriesEvent extends CategoriesEvent {
  @override
  List<Object?> get props => [];
}

class LoadSubCategoriesEvent extends CategoriesEvent {
  @override
  List<Object?> get props => [];
}
