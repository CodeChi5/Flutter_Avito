import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/user/blocs/user_event.dart';
import 'package:myapp/user/blocs/user_state.dart';
import 'package:myapp/user/data/user_repo.dart';

class UserBLoc extends Bloc<UserEvent, UserState> {
  final UserRepo repo;
  UserBLoc(this.repo) : super(UsercalmState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
    });
  }

  @override
  Future<String> SendCodeRegisterUser(UserTrigerState event) async {
    print('45564654');
    emit(UserLoadingState());
    String response = await repo.SendCodeRegisterSendCode(event.phone);

    return response;
  }

  Future<String> VerifyCodeRegisterUser(UserCodeTrigerState event) async {
    print('45564654');
    emit(UserLoadingState());
    String response =
        await repo.VerifyCodeRegisterSendCode(event.phone, event.code);

    return response;
  }
}
