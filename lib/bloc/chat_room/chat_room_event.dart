part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();

  @override
  List<Object> get props => [];
}

class ChatRoomLoaded extends ChatRoomEvent {}

class ChatRoomSentMessage extends ChatRoomEvent {
  const ChatRoomSentMessage({
    required this.message,
  });
  final Message message;
  @override
  List<Object> get props => [message];
}

class ChatRoomReceivedMessages extends ChatRoomEvent {
  const ChatRoomReceivedMessages({
    required this.messages,
  });

  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}
