import 'dart:async';

import 'package:chat_app_bloc/models/chat_room.dart';
import 'package:chat_app_bloc/models/user.dart';
import 'package:chat_app_bloc/provider_data/provider_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RepoChatList {
  RepoChatList({
    required this.providerChat,
  });
  final ProviderChat providerChat;

  setChatRoom(User currentUser, User friend) async {
    //! check if chat room exists before creation
    //? create new chat room
    providerChat.setChatRoomToFireStore(currentUser, friend);
  }

  //? get the chat list by idChatRoom
  Stream<List<ChatRoom>> getChatList(List<String> idChatList) {
    return providerChat
        .getChatRoomFromFirestore(idChatList)
        .transform(queryToChatList);
  }

  late StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<ChatRoom>>
      queryToChatList = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          List<ChatRoom>>.fromHandlers(
    handleData: (datas, sink) {
      List<ChatRoom> result = [];

      for (var data in datas.docs) {
        List<User> users = [];
        //? get user list of chat room
        data.reference
            .collection('user_list')
            .snapshots()
            .transform(queryToListUserOfChatRoom)
            .listen((event) {
          users.addAll(event);
        });

        result.add(ChatRoom(
          id: data['id'],
          idUserSendLastMessage: data['idUserSendLastMessage'],
          lastMessage: data['lastMessage'],
          lastModifiedTime: data['lastModifiedTime'],
          users: users,
        ));
      }
      sink.add(result);
    },
  );

  late StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<User>>
      queryToListUserOfChatRoom = StreamTransformer<
          QuerySnapshot<Map<String, dynamic>>, List<User>>.fromHandlers(
    handleData: (datas, sink) {
      List<User> result = [];
      for (var data in datas.docs) {
        result.add(User(
          id: data['id'],
          email: data['email'],
          username: data['username'],
          img: data['img'],
        ));
      }
      sink.add(result);
    },
  );

  //? get id chat list of user
  Stream<List<String>> getIdChatList(String idUser) {
    return providerChat
        .getIdChatListFromFirestore(idUser)
        .transform(documentToIdChatList);
  }

  late StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, List<String>>
      documentToIdChatList = StreamTransformer<
          DocumentSnapshot<Map<String, dynamic>>, List<String>>.fromHandlers(
    handleData: (data, sink) {
      if (data.exists) {
        sink.add(data.data()!.keys.toList());
      } else {
        sink.add([]);
      }
    },
  );
}
