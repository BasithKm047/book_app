// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageModelAdapter extends TypeAdapter<LanguageModel> {
  @override
  final int typeId = 5;

  @override
  LanguageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageModel(
      fields[1] as String,
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
