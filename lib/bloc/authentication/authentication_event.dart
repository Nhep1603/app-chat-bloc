part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLoaded extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {}
