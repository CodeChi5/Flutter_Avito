import 'package:equatable/equatable.dart';

abstract class AskLoginState extends Equatable {
  const AskLoginState();

  @override
  List<Object?> get props => [];
}

class AskLoginInitial extends AskLoginState {}

class AskLoginLoading extends AskLoginState {}

class AskLoginSuccess extends AskLoginState {
  final String message;
  final bool isGoogleLogin;
  final bool isPhoneEmailLogin;
  final bool isRegister;

  const AskLoginSuccess({
    required this.message,
    this.isGoogleLogin = false,
    this.isPhoneEmailLogin = false,
    this.isRegister = false,
  });

  @override
  List<Object?> get props =>
      [message, isGoogleLogin, isPhoneEmailLogin, isRegister];
}

class AskLoginError extends AskLoginState {
  final String message;

  const AskLoginError(this.message);

  @override
  List<Object?> get props => [message];
}
