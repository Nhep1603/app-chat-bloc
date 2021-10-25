import 'package:chat_app_bloc/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//? Provider for repo_user and repo_user_list
class ProviderUser {
  final _firestore = FirebaseFirestore.instance;

  //? Return user object if user datas's written
  //? On the contrary, return user empty object
  Future<User> getUserFromFirestore(String id) async {
    var doc = await _firestore.collection('user').doc(id).get();
    if (doc.exists) {
      return User.fromMap(doc.data()!);
    }
    return User.emptyUser;
  }

  //? write new user
  Future registerUserToFirestore(User user) async {
    return await _firestore.collection('user').doc(user.id).set(user.toMap());
  }

  //? get user list
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserListFromFirestore() {
    return _firestore.collection('user').snapshots();
  }
}
