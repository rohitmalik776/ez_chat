import 'dart:convert';

class Message {
  late final String text;
  late final String author;
  late final DateTime timestamp;
  // Default constructor
  Message({required this.text, required this.author, required this.timestamp});
  Message.fromJson(String data) {
    try {
      Map<String, dynamic> recData = jsonDecode(data);
      text = recData['text'];
      author = recData['author'];
      timestamp = DateTime.parse(recData['timestamp']);
    } on Exception catch (e) {
      print(e);
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
