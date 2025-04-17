import 'package:equatable/equatable.dart';

abstract class AskLoginEvent extends Equatable {
  const AskLoginEvent();

  @override
  List<Object?> get props => [];
}

class AskLoginGooglePressed extends AskLoginEvent {}

class AskLoginPhoneEmailPressed extends AskLoginEvent {}

class AskLoginRegisterPressed extends AskLoginEvent {}

class AskLoginReset extends AskLoginEvent {}

class AskLoginNavigateBack extends AskLoginEvent {}
