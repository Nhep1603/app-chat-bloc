// ignore_for_file: annotate_overrides, overridden_fields

part of 'account_directories_bloc.dart';

abstract class AccountDirectoriesState extends Equatable {
  const AccountDirectoriesState({
    this.userList = const [],
  });

  final List<User> userList;

  @override
  List<Object> get props => [userList];
}

class AccountDirectoriesInitial extends AccountDirectoriesState {}

class AccountDirectoriesLoadSuccess extends AccountDirectoriesState {
  const AccountDirectoriesLoadSuccess({
    required this.userList,
  }) : super(userList: userList);

  final List<User> userList;

  @override
  List<Object> get props => [userList];
}

class AccountDirectoriesLoadFailure extends AccountDirectoriesState {}
