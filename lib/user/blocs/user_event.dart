import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}
