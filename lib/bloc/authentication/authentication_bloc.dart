import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/models/user.dart';
import 'package:chat_app_bloc/repository/repo_user.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.repoUser,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationLoaded>(_onLoad);
    on<AuthenticationLoggedOut>(_onLogOut);
  }

  final RepoUser repoUser;

  _onLoad(AuthenticationLoaded event, Emitter<AuthenticationState> emit) async {
    final isSignedIn = await repoUser.isSignedIn();
    if (isSignedIn) {
      final user = await repoUser.getUser();
      emit(AuthenticationSuccess(user: user));
    } else {
      emit(AuthenticationFailure());
    }
  }

  _onLogOut(AuthenticationLoggedOut event, Emitter<AuthenticationState> emit) async {
    await repoUser.signOut();
    emit(AuthenticationFailure());
  }

}
