import 'package:chat_app_bloc/models/user.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60.0,
          width: 60.0,
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.img),
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Text(
            user.username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
