// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenresModelAdapter extends TypeAdapter<GenresModel> {
  @override
  final int typeId = 2;

  @override
  GenresModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenresModel(
      name: fields[0] as String,
      books: (fields[1] as List).cast<Book>(),
    );
  }

  @override
  void write(BinaryWriter writer, GenresModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.books);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenresModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
