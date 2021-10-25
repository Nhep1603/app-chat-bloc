import 'dart:convert';

class User {
  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.img,
  });
  final String id;
  final String email;
  final String username;
  final String img;

  static const emptyUser = User(
    id: 'one',
    email: 'defaultEmail',
    username: 'default',
    img:
        'https://gitlab.com/uploads/-/system/user/avatar/9821785/avatar.png?width=90',
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'img': img,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      img: map['img'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
