class ChatMessage {
  final String role;
  final String content;

  ChatMessage({required this.role, required this.content});

  factory ChatMessage.fromSharedPreferences(Map<String, dynamic> json) {
    return ChatMessage(
        role: json["role"], content: json["content"]);
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        role: json["data"]["role"], content: json["data"]["content"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
