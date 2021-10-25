import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/repository/repo_user.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.repoUser}) : super(LoginInitial()) {
    on<LoggedInWithGoogle>(_onLoginWithGoogle);
  }

  final RepoUser repoUser;

  _onLoginWithGoogle(LoggedInWithGoogle event, Emitter<LoginState> emit) async {
    try {
      await repoUser.googleLogin();
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure());
    }
  }
}
