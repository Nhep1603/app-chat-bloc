import 'dart:async';

import 'package:chat_app_bloc/models/user.dart';
import 'package:chat_app_bloc/provider_data/provider_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RepoUserList {
  RepoUserList({
    required this.providerUser,
  });

  final ProviderUser providerUser;

  //? get user list
  Stream<List<User>> getUserList() {
    return providerUser.getUserListFromFirestore().transform(queryToUserList);
  }

  late StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<User>>
      queryToUserList = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          List<User>>.fromHandlers(
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
}
