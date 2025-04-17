import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class PhoneVerificationSent extends AuthState {
  final String phoneNumber;

  const PhoneVerificationSent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class PhoneVerificationSuccess extends AuthState {
  final String phoneNumber;
  final String token;
  final int userId;

  const PhoneVerificationSuccess(
    this.phoneNumber, {
    required this.token,
    required this.userId,
  });

  @override
  List<Object?> get props => [phoneNumber, token, userId];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
