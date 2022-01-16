import 'dart:convert';
import 'dart:typed_data';

class Message {
  /// Default constructor
  Message({
    required this.text,
    required this.author,
    required this.timestamp,
    this.imageBytes,
  });

  factory Message.fromJson(String data) {
    late final String text;
    late final String author;
    late final DateTime timestamp;
    late final Uint8List imageBytes;
    try {
      Map<String, dynamic> recData = jsonDecode(data);
      text = recData['text'];
      author = recData['author'];
      timestamp = DateTime.parse(recData['timestamp']);
      var imageBytesList = recData['imageBytes'];
      List<int> newList = List<int>.from(imageBytesList);
      imageBytes = Uint8List.fromList(newList);
    } on Exception catch (e) {
      throw e;
    }
    return Message(
        text: text,
        author: author,
        timestamp: timestamp,
        imageBytes: imageBytes);
  }
  final String text;
  final String author;
  final DateTime timestamp;
  final Uint8List? imageBytes;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
      'timestamp': timestamp.toIso8601String(),
      'imageBytes': imageBytes,
    };
  }
}
