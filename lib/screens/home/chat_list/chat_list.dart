import 'package:chat_app_bloc/bloc/authentication/authentication_bloc.dart';
import 'package:chat_app_bloc/bloc/chat_list/chat_list_bloc.dart';
import 'package:chat_app_bloc/bloc/chat_room/chat_room_bloc.dart';
import 'package:chat_app_bloc/models/chat_room.dart';
import 'package:chat_app_bloc/repository/repo_chat_room.dart';
import 'package:chat_app_bloc/screens/chat_room/chat_room_screen.dart';
import 'package:chat_app_bloc/screens/home/chat_list/chat_list_item.dart';
import 'package:chat_app_bloc/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //? Search box
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 10.0,
            ),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                focusColor: Colors.white,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipOval(
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0xff15099F),
                          Color(0xff0D83D6),
                        ],
                      )),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                hintText: 'Search ...',
                hintStyle: const TextStyle(
                  color: Color(0xffd9c3ce),
                  fontWeight: FontWeight.w300,
                ),
                filled: true,
                fillColor: Colors.white,
                border: Constants.border,
                focusedBorder: Constants.border,
                disabledBorder: Constants.border,
                enabledBorder: Constants.border,
              ),
            ),
          ),
          //? Chat list
          Expanded(
            child: BlocBuilder<ChatListBloc, ChatListState>(
              builder: (context, state) {
                return state.chatList.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                          right: 20.0,
                          bottom: 60.0,
                        ),
                        itemCount: state.chatList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                _onTapChatRoom(state.chatList[index], context);
                              },
                              child: ChatListItem(
                                  chatRoom: state.chatList[index]));
                        },
                      )
                    : const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }

  void _onTapChatRoom(ChatRoom chatRoom, BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 750),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Builder(builder: (context) {
              final currentUser =
                  context.select((AuthenticationBloc bloc) => bloc.state.user);
              return BlocProvider(
                create: (context) => ChatRoomBloc(
                  currentUser: currentUser,
                  idChatRoom: chatRoom.id!,
                  repoChatRoom: context.read<RepoChatRoom>(),
                )..add(ChatRoomLoaded()),
                child: ChatRoomScreen(
                  chatRoom: chatRoom,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
