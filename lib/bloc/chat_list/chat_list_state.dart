// ignore_for_file: annotate_overrides, overridden_fields

part of 'chat_list_bloc.dart';

abstract class ChatListState extends Equatable {
  const ChatListState({
    this.chatList = const [],
  });

  final List<ChatRoom> chatList;

  @override
  List<Object> get props => [chatList];
}

class ChatListInitial extends ChatListState {}

class ChatListLoadSuccess extends ChatListState {
  const ChatListLoadSuccess({
    required this.chatList,
  }) : super(
          chatList: chatList,
        );

  final List<ChatRoom> chatList;

  @override
  List<Object> get props => [chatList];
}
