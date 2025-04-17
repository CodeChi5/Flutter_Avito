import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/user/blocs/ask_login_event.dart';
import 'package:myapp/user/blocs/ask_login_state.dart';

class AskLoginBloc extends Bloc<AskLoginEvent, AskLoginState> {
  AskLoginBloc() : super(AskLoginInitial()) {
    on<AskLoginGooglePressed>((event, emit) {
      emit(AskLoginLoading());
      emit(const AskLoginSuccess(
        message: 'Google login initiated',
        isGoogleLogin: true,
      ));
    });

    on<AskLoginPhoneEmailPressed>((event, emit) {
      emit(AskLoginLoading());
      emit(const AskLoginSuccess(
        message: 'Phone/Email login initiated',
        isPhoneEmailLogin: true,
      ));
    });

    on<AskLoginRegisterPressed>((event, emit) {
      emit(AskLoginLoading());
      emit(const AskLoginSuccess(
        message: 'Registration initiated',
        isRegister: true,
      ));
    });

    on<AskLoginReset>((event, emit) {
      emit(AskLoginInitial());
    });

    on<AskLoginNavigateBack>((event, emit) {
      emit(AskLoginInitial());
    });
  }

  void resetState() {
    add(AskLoginReset());
  }
}
