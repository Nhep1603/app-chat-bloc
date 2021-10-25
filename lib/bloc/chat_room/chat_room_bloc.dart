import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/models/message.dart';
import 'package:chat_app_bloc/models/user.dart';
import 'package:chat_app_bloc/repository/repo_chat_room.dart';
import 'package:equatable/equatable.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc({
    required this.currentUser,
    required this.idChatRoom,
    required this.repoChatRoom,
  }) : super(ChatRoomInitial()) {
    on<ChatRoomLoaded>(_onLoad);
    on<ChatRoomSentMessage>(_onSendMessage);
    on<ChatRoomReceivedMessages>(_onReceiveMessages);
  }

  final User currentUser;
  final String idChatRoom;
  final RepoChatRoom repoChatRoom;
  late final StreamSubscription _messagesOfChatRoom;

  _onLoad(ChatRoomLoaded event, Emitter<ChatRoomState> emit) {
    _messagesOfChatRoom =
        repoChatRoom.getMessagesOfChatRoom(idChatRoom).listen((messages) {
      if (messages.isEmpty) {
        add(const ChatRoomReceivedMessages(messages: []));
      } else {
        add(ChatRoomReceivedMessages(messages: messages));
      }
    });
  }

  _onSendMessage(ChatRoomSentMessage event, Emitter<ChatRoomState> emit) async {
    await repoChatRoom.sendChatMessage(idChatRoom, event.message);
    await repoChatRoom.updateLastMessageOfChatRoom(idChatRoom, event.message);
  }

  _onReceiveMessages(
      ChatRoomReceivedMessages event, Emitter<ChatRoomState> emit) {
        emit(ChatRoomLoadSuccess(messages: event.messages));
      }

  @override
  Future<void> close() {
    _messagesOfChatRoom.cancel();
    return super.close();
  }
}
