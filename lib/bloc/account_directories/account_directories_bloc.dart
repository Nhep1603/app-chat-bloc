import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/models/user.dart';
import 'package:chat_app_bloc/repository/repo_user_list.dart';
import 'package:equatable/equatable.dart';

part 'account_directories_event.dart';
part 'account_directories_state.dart';

class AccountDirectoriesBloc
    extends Bloc<AccountDirectoriesEvent, AccountDirectoriesState> {
  AccountDirectoriesBloc({required this.repoUserList})
      : super(AccountDirectoriesInitial()) {
    on<AccountDirectoriesStarted>(_onStart);
    on<AccountDirectoriesLoaded>(_onLoad);
  }

  final RepoUserList repoUserList;
  late final StreamSubscription _userListStreamSubscription;

  _onStart(
      AccountDirectoriesStarted event, Emitter<AccountDirectoriesState> emit) {
    _userListStreamSubscription = repoUserList.getUserList().listen((users) {
      if (users.isEmpty) {
        add(const AccountDirectoriesLoaded(userList: []));
      } else {
        add(AccountDirectoriesLoaded(userList: users));
      }
    });
  }

  _onLoad(
      AccountDirectoriesLoaded event, Emitter<AccountDirectoriesState> emit) {
    emit(AccountDirectoriesLoadSuccess(userList: event.userList));
  }

  @override
  Future<void> close() {
    _userListStreamSubscription.cancel();
    return super.close();
  }
}
