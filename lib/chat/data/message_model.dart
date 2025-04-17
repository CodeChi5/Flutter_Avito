class Message {
  final int id;
  final int conversation;
  final User sender;
  final String content;
  final bool isRead;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.conversation,
    required this.sender,
    required this.content,
    required this.isRead,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      conversation: json['conversation'] as int,
      sender: User.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String,
      isRead: json['is_read'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation': conversation,
      'sender': sender.toJson(),
      'content': content,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class User {
  final int id;
  final String username;
  final String phoneNumber;

  User({
    required this.id,
    required this.username,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      phoneNumber: json['phone_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone_number': phoneNumber,
    };
  }
}
