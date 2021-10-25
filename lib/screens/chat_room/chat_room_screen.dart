import 'package:chat_app_bloc/bloc/authentication/authentication_bloc.dart';
import 'package:chat_app_bloc/bloc/chat_room/chat_room_bloc.dart';
import 'package:chat_app_bloc/models/chat_room.dart';
import 'package:chat_app_bloc/models/message.dart';
import 'package:chat_app_bloc/screens/chat_room/chat_message_input.dart';
import 'package:chat_app_bloc/screens/chat_room/chat_message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({
    Key? key,
    required this.chatRoom,
  }) : super(key: key);

  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        title: Row(
          children: [
            ...List.generate(chatRoom.users.length, (index) {
              return chatRoom.users[index].id != currentUser.id ?
              Text(chatRoom.users[index].username) : const SizedBox.shrink();
            })
          ],
        ),
        actions: [
          Row(
            children: [
              ...List.generate(chatRoom.users.length, (index) {
                return chatRoom.users[index].id != currentUser.id
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(chatRoom.users[index].img),
                      )
                    : const SizedBox.shrink();
              }),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      ...List.generate(state.messages.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child:
                              ChatMessageItem(message: state.messages[index]),
                        );
                      })
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChatMessageInput(onPressed: (message) {
                  context.read<ChatRoomBloc>().add(ChatRoomSentMessage(
                          message: Message(
                        senderId: currentUser.id,
                        message: message,
                        time: DateTime.now().millisecondsSinceEpoch.toString(),
                      )));
                }),
              )
            ],
          );
        },
      ),
    );
  }
}
