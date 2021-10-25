class Message {
  Message({
    required this.senderId,
    required this.message,
    required this.time,
  });

  final String senderId;
  final String message;
  final String time;

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'time': time,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      message: map['message'],
      time: map['time'],
    );
  }
}
