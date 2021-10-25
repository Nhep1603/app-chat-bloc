part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.user = User.emptyUser,
  });

  final User user;

  @override
  List<Object> get props => [user];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess({
    required this.user,
  }) : super(user: user);

  // ignore: annotate_overrides, overridden_fields
  final User user;

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {}
