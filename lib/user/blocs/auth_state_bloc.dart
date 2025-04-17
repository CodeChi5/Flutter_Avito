import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/user/data/user_repo.dart';

// Events
abstract class AuthStateEvent extends Equatable {
  const AuthStateEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthState extends AuthStateEvent {}

class UpdateAuthState extends AuthStateEvent {
  final bool isAuthenticated;
  final String? token;
  final int? userId;

  const UpdateAuthState({
    required this.isAuthenticated,
    this.token,
    this.userId,
  });

  @override
  List<Object?> get props => [isAuthenticated, token, userId];
}

// States
class AuthStateState extends Equatable {
  final bool isAuthenticated;
  final String? token;
  final int? userId;
  final bool isLoading;

  const AuthStateState({
    this.isAuthenticated = false,
    this.token,
    this.userId,
    this.isLoading = true,
  });

  AuthStateState copyWith({
    bool? isAuthenticated,
    String? token,
    int? userId,
    bool? isLoading,
  }) {
    return AuthStateState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, token, userId, isLoading];
}

// Bloc
class AuthStateBloc extends Bloc<AuthStateEvent, AuthStateState> {
  final UserRepo userRepo;

  AuthStateBloc({required this.userRepo}) : super(const AuthStateState()) {
    on<CheckAuthState>(_onCheckAuthState);
    on<UpdateAuthState>(_onUpdateAuthState);
  }

  Future<void> _onCheckAuthState(
    CheckAuthState event,
    Emitter<AuthStateState> emit,
  ) async {
    final token = await userRepo.getToken();
    final userId = await userRepo.getUserId();

    emit(AuthStateState(
      isAuthenticated: token != null,
      token: token,
      userId: userId,
      isLoading: false,
    ));
  }

  void _onUpdateAuthState(
    UpdateAuthState event,
    Emitter<AuthStateState> emit,
  ) {
    emit(AuthStateState(
      isAuthenticated: event.isAuthenticated,
      token: event.token,
      userId: event.userId,
      isLoading: false,
    ));
  }
}
