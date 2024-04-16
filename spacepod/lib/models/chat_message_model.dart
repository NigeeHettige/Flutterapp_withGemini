import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessageModel {
  final String role;
  final List<ChatPartModel> parts;

  ChatMessageModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'parts': parts.map((part) => part.toMap()).toList(),
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      role: map['role'] as String,
      parts: (map['parts'] as List<dynamic>?)
          ?.map((partMap) => ChatPartModel.fromMap(partMap as Map<String, dynamic>))
          .toList()
          ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageModel.fromJson(String source) =>
      ChatMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChatPartModel {
  final String text;

  ChatPartModel({
     required this.text,
  }
   
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory ChatPartModel.fromMap(Map<String, dynamic> map) {
    return ChatPartModel(
      text:map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPartModel.fromJson(String source) =>
      ChatPartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
