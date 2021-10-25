import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/models/chat_room.dart';
import 'package:chat_app_bloc/models/user.dart';
import 'package:chat_app_bloc/repository/repo_chat_list.dart';
import 'package:equatable/equatable.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc({
    required this.repoChatList,
    required this.currentUser,
  }) : super(ChatListInitial()) {
    on<ChatListStarted>(_onStart);
    on<ChatListSetChatRoom>(_onSetChatRoom);
    on<ChatListLoaded>(_onLoad);
  }

  final RepoChatList repoChatList;
  final User currentUser;
  late final StreamSubscription _idChatListOfCurrentUserStreamSubscription;
  late final StreamSubscription _chatListStreamSubscription;

  _onStart(ChatListStarted event, Emitter<ChatListState> emit) {
    _idChatListOfCurrentUserStreamSubscription =
        repoChatList.getIdChatList(currentUser.id).listen((idChatList) {
      if (idChatList.isEmpty) {
        add(const ChatListLoaded(chatList: []));
      } else {
        _chatListStreamSubscription =
            repoChatList.getChatList(idChatList).listen((chatList) {
          add(ChatListLoaded(chatList: chatList));
        });
      }
    });
  }

  _onSetChatRoom(ChatListSetChatRoom event, Emitter<ChatListState> emit) async {
    await repoChatList.setChatRoom(event.currentUser, event.friend);
  }

  _onLoad(ChatListLoaded event, Emitter<ChatListState> emit) {
    emit(ChatListLoadSuccess(chatList: event.chatList));
  }

  @override
  Future<void> close() {
    _chatListStreamSubscription.cancel();
    _idChatListOfCurrentUserStreamSubscription.cancel();

    return super.close();
  }
}
