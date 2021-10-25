import 'package:chat_app_bloc/bloc/authentication/authentication_bloc.dart';
import 'package:chat_app_bloc/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageItem extends StatelessWidget {
  const ChatMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthenticationBloc bloc) => bloc.state.user);
    final isMe = currentUser.id == message.senderId;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xff0D83D6) : Colors.grey,
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(20.0),
              topLeft: const Radius.circular(20.0),
              bottomLeft: Radius.circular(isMe ? 20.0 : 0.0),
              bottomRight: Radius.circular(isMe ? 0.0 : 20.0),
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
            maxHeight: 30.0,
          ),
          child: Text(
            message.message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
