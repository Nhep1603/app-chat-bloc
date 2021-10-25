import 'package:chat_app_bloc/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatMessageInput extends StatefulWidget {
  const ChatMessageInput({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function onPressed;
  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Please enter the message ...',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: Constants.border,
              disabledBorder: Constants.border,
              border: Constants.border,
              errorBorder: Constants.border,
              focusedBorder: Constants.border,
              focusedErrorBorder: Constants.border,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            widget.onPressed(_controller.text);
            _controller.clear();
          },
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xff15099F),
                  Color(0xff0D83D6),
                ],
              ),
            ),
            child: const Icon(
              Icons.send_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
