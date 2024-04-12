// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMessageModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = 2;

  @override
  ChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessage(
      id: fields[0] as String?,
      message: fields[1] as String?,
      isUserMessage: fields[3] as bool?,
      date: fields[4] as String?,
      images: (fields[2] as List).cast<String>(),
      selectedModel: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.images)
      ..writeByte(3)
      ..write(obj.isUserMessage)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.selectedModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
