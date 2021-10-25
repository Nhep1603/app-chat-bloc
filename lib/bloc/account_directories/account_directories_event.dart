part of 'account_directories_bloc.dart';

abstract class AccountDirectoriesEvent extends Equatable {
  const AccountDirectoriesEvent();

  @override
  List<Object> get props => [];
}

class AccountDirectoriesStarted extends AccountDirectoriesEvent {}

class AccountDirectoriesLoaded extends AccountDirectoriesEvent {
  const AccountDirectoriesLoaded({
    required this.userList,
  });

  final List<User> userList;
}
