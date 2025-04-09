import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UsercalmState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserTrigerState extends UserState {
  final String phone;

  UserTrigerState({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class UserCodeTrigerState extends UserState {
  final String phone;
  final String code;

  UserCodeTrigerState({required this.phone, required this.code});

  @override
  List<Object?> get props => [phone, code];
}
