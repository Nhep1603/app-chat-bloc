import 'dart:async';

import 'package:chat_app_bloc/models/message.dart';
import 'package:chat_app_bloc/provider_data/provider_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RepoChatRoom {
  RepoChatRoom({
    required this.providerChat,
  });
  final ProviderChat providerChat;

  //? get messages of chat room
  Stream<List<Message>> getMessagesOfChatRoom(String idChatRoom) {
    return providerChat
        .getMessagesOfChatRoom(idChatRoom)
        .transform(queryToMessagesOfChatRoom);
  }

  late StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Message>>
      queryToMessagesOfChatRoom = StreamTransformer<
          QuerySnapshot<Map<String, dynamic>>, List<Message>>.fromHandlers(
    handleData: (datas, sink) {
      List<Message> result = [];

      for (var data in datas.docs) {
        result.add(Message(
          senderId: data['senderId'],
          message: data['message'],
          time: data['time'],
        ));
      }
      sink.add(result);
    },
  );

  //? send message
  sendChatMessage(String idChatRoom, Message message) async {
    return await providerChat.sendChatMessageToFirestore(idChatRoom, message);
  }

  //? update last message of chat room
  updateLastMessageOfChatRoom(String idChatRoom, Message message) async {
    return await providerChat.updateLastMessageOfChatRoom(idChatRoom, message);
  }
}
