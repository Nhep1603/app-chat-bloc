import 'package:chat_app_bloc/models/user.dart';

class ChatRoom {
  ChatRoom({
    this.id,
    required this.idUserSendLastMessage,
    required this.lastMessage,
    required this.lastModifiedTime,
    this.users = const [],
  });

  final String? id;
  final String idUserSendLastMessage;
  final String lastMessage;
  final String lastModifiedTime;
  final List<User> users;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUserSendLastMessage': idUserSendLastMessage,
      'lastMessage': lastMessage,
      'lastModifiedTime': lastModifiedTime,
      'users': []
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      idUserSendLastMessage: map['idUserSendLastMessage'],
      lastMessage: map['lastMessage'],
      lastModifiedTime: map['lastModifiedTime'],
      users: map['users']
    );
  }
}