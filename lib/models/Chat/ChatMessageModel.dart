import 'package:hive/hive.dart';

part 'ChatMessageModel.g.dart';

@HiveType(typeId: 2)
class ChatMessage {
  ChatMessage({
    required this.id,
    required this.message,
    required this.isUserMessage,
    required this.date,
    required this.images
  });

  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? message;

  @HiveField(2)
  final List<String> images;

  @HiveField(3)
  final bool? isUserMessage;

  @HiveField(4)
  final String? date;

  factory ChatMessage.fromJson(Map<String, dynamic> json){
    return ChatMessage(
      id: json["id"],
      message: json["message"],
      images: json["images"],
      isUserMessage: json["isUserMessage"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "images": images,
    "isUserMessage": isUserMessage,
    "date": date,
  };

}
