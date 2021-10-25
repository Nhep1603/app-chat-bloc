import 'package:chat_app_bloc/bloc/account_directories/account_directories_bloc.dart';
import 'package:chat_app_bloc/bloc/authentication/authentication_bloc.dart';
import 'package:chat_app_bloc/bloc/chat_list/chat_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_list_item.dart';

class AccountDirectories extends StatelessWidget {
  const AccountDirectories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<AccountDirectoriesBloc, AccountDirectoriesState>(
      builder: (context, state) {
        return state.userList.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 60.0,
                ),
                itemCount: state.userList.length,
                itemBuilder: (context, index) {
                  return state.userList[index].id != currentUser.id
                      ? GestureDetector(
                          onTap: () async {
                            context
                                .read<ChatListBloc>()
                                .add(ChatListSetChatRoom(
                                  currentUser: currentUser,
                                  friend: state.userList[index],
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AccountListItem(
                              user: state.userList[index],
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              )
            : const SizedBox.shrink();
      },
    );
  }
}
