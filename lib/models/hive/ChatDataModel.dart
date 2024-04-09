import 'package:hive/hive.dart';

import '../Chat/ChatMessageModel.dart';

part 'ChatDataModel.g.dart';

@HiveType(typeId: 1)
class ChatData {
  ChatData({
    required this.chatID,
    required this.username,
    required this.AIType,
    required this.messages,
    required this.lastModifiedDate
  });

  @HiveField(0)
  String chatID;

  @HiveField(1)
  String username;

  @HiveField(2)
  int AIType;

  @HiveField(3)
  List<ChatMessage> messages;

  @HiveField(4)
  String lastModifiedDate;


}