import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {}

class LoadProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}
