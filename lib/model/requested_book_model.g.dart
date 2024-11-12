// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestedBookModelAdapter extends TypeAdapter<RequestedBookModel> {
  @override
  final int typeId = 7;

  @override
  RequestedBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequestedBookModel(
      id: fields[0] as int,
      bookName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RequestedBookModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bookName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestedBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
