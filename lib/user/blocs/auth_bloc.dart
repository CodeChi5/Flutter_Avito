import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/user/blocs/auth_event.dart';
import 'package:myapp/user/blocs/auth_state.dart';
import 'package:myapp/user/blocs/auth_state_bloc.dart';
import 'package:myapp/user/data/user_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo userRepo;
  final AuthStateBloc authStateBloc;

  AuthBloc(this.userRepo, this.authStateBloc) : super(AuthInitial()) {
    on<SendPhoneVerification>(_onSendPhoneVerification);
    on<VerifyPhoneCode>(_onVerifyPhoneCode);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<ResetAuthState>(_onResetAuthState);
  }

  Future<void> _onSendPhoneVerification(
    SendPhoneVerification event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final success = await userRepo.sendPhoneVerification(event.phoneNumber);

      if (success) {
        emit(PhoneVerificationSent(event.phoneNumber));
      } else {
        emit(const AuthError(
            'Failed to send verification code. Please try again.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerifyPhoneCode(
    VerifyPhoneCode event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final result = await userRepo.verifyPhoneCode(
        event.phoneNumber,
        event.code,
      );

      if (result['success']) {
        // Update the global auth state
        authStateBloc.add(
          UpdateAuthState(
            isAuthenticated: true,
            token: result['token'],
            userId: result['userId'],
          ),
        );

        emit(PhoneVerificationSuccess(
          event.phoneNumber,
          token: result['token'],
          userId: result['userId'],
        ));
      } else {
        emit(AuthError(
            result['error'] ?? 'Invalid verification code. Please try again.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthError('Google Sign-In is not available yet.'));
  }

  void _onResetAuthState(
    ResetAuthState event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthInitial());
  }
}
