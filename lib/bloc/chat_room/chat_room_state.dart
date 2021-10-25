// ignore_for_file: annotate_overrides, overridden_fields

part of 'chat_room_bloc.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState({this.messages = const []});

  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}

class ChatRoomInitial extends ChatRoomState {}

class ChatRoomLoadSuccess extends ChatRoomState {
  const ChatRoomLoadSuccess({required this.messages})
      : super(messages: messages);

  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}
