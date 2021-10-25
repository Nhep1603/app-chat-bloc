part of 'chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

class ChatListStarted extends ChatListEvent {}

class ChatListSetChatRoom extends ChatListEvent {
  const ChatListSetChatRoom({
    required this.currentUser,
    required this.friend,
  });

  final User currentUser;
  final User friend;

  @override
  List<Object> get props => [currentUser, friend];
}

class ChatListLoaded extends ChatListEvent {
  const ChatListLoaded({
    required this.chatList,
  });

  final List<ChatRoom> chatList;

  @override
  List<Object> get props => [chatList];
}
