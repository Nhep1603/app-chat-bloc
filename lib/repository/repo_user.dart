import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app_bloc/models/user.dart' as us;
import 'package:chat_app_bloc/provider_data/provider_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RepoUser {
  RepoUser({
    required this.providerUser,
  });

  final ProviderUser providerUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //? Check if user has signed in or not
  //? return true => signed in
  //? On the contrary,return false
  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  //? login in with Google account
  Future googleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  //? Check if there's no user information in firestore => write in firestore
  //? Return user object
  Future<us.User> getUser() async {
    var firebaseAuthUser = _firebaseAuth.currentUser;
    var user = await providerUser.getUserFromFirestore(firebaseAuthUser!.uid);
    if (user == us.User.emptyUser) {
      user = us.User(
        id: firebaseAuthUser.uid,
        email: firebaseAuthUser.email ?? 'not register email',
        username: firebaseAuthUser.displayName ?? 'not register username',
        img: firebaseAuthUser.photoURL ?? 'https://gitlab.com/uploads/-/system/user/avatar/9821785/avatar.png?width=90',
      );
      await providerUser.registerUserToFirestore(user);
    }
    return user;
  }

  //? sign out
  signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }
}
