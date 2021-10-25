import 'package:chat_app_bloc/bloc/authentication/authentication_bloc.dart';
import 'package:chat_app_bloc/models/chat_room.dart';
import 'package:chat_app_bloc/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    Key? key,
    required this.chatRoom,
  }) : super(key: key);

  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Row(
      children: [
        SizedBox(
          child: Column(
            children: [
              ...List.generate(chatRoom.users.length, (index) {
                return chatRoom.users[index].id != currentUser.id ? CircleAvatar(
                  backgroundImage: NetworkImage(
                      chatRoom.users[index].img),
                ) : const SizedBox.shrink();
              }),
            ],
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(chatRoom.users.length, (index) {
                return chatRoom.users[index].id != currentUser.id
                    ? Text(
                        chatRoom.users[index].username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox.shrink();
              }),
              Text(
                chatRoom.lastMessage,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(
          Constants.millisecondsToFormatString(chatRoom.lastModifiedTime),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
