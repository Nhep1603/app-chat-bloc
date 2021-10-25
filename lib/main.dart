// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/app_bloc_observer.dart';
import 'package:chat_app_bloc/bloc/home/home_bloc.dart';
import 'package:chat_app_bloc/provider_data/provider_chat.dart';
import 'package:chat_app_bloc/provider_data/provider_user.dart';
import 'package:chat_app_bloc/repository/repo_chat_list.dart';
import 'package:chat_app_bloc/repository/repo_chat_room.dart';
import 'package:chat_app_bloc/repository/repo_user.dart';
import 'package:chat_app_bloc/repository/repo_user_list.dart';
import 'package:chat_app_bloc/screens/home/home.dart';
import 'package:chat_app_bloc/screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/chat_list/chat_list_bloc.dart';
import 'bloc/login/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => ProviderUser(),
      ),
      RepositoryProvider(
        create: (context) => ProviderChat(),
      ),
      RepositoryProvider(
        create: (context) =>
            RepoUser(providerUser: context.read<ProviderUser>()),
      ),
      RepositoryProvider(
        create: (context) =>
            RepoUserList(providerUser: context.read<ProviderUser>()),
      ),
      RepositoryProvider(
        create: (context) =>
            RepoChatList(providerChat: context.read<ProviderChat>()),
      ),
      RepositoryProvider(
        create: (context) =>
            RepoChatRoom(providerChat: context.read<ProviderChat>()),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            repoUser: context.read<RepoUser>(),
          )..add(AuthenticationLoaded()),
        ),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthenticationBloc bloc) => bloc.state.user);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return state is AuthenticationSuccess
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => HomeBloc(),
                    ),
                    BlocProvider(
                      create: (context) => ChatListBloc(
                        repoChatList: context.read<RepoChatList>(),
                        currentUser: currentUser,
                      )..add(ChatListStarted()),
                    ),
                  ],
                  child: Home(),
                )
              : BlocProvider(
                  create: (context) =>
                      LoginBloc(repoUser: context.read<RepoUser>()),
                  child: Login(),
                );
        },
      ),
    );
  }
}
