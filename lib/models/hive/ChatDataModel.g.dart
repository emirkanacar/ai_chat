// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatDataModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatDataAdapter extends TypeAdapter<ChatData> {
  @override
  final int typeId = 1;

  @override
  ChatData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatData(
      chatID: fields[0] as String,
      username: fields[1] as String,
      AIType: fields[2] as int,
      messages: (fields[3] as List).cast<ChatMessage>(),
      lastModifiedDate: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.chatID)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.AIType)
      ..writeByte(3)
      ..write(obj.messages)
      ..writeByte(4)
      ..write(obj.lastModifiedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
