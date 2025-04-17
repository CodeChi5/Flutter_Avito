import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendPhoneVerification extends AuthEvent {
  final String phoneNumber;

  const SendPhoneVerification(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyPhoneCode extends AuthEvent {
  final String phoneNumber;
  final String code;

  const VerifyPhoneCode({
    required this.phoneNumber,
    required this.code,
  });

  @override
  List<Object?> get props => [phoneNumber, code];
}

class GoogleSignInRequested extends AuthEvent {}

class ResetAuthState extends AuthEvent {}
