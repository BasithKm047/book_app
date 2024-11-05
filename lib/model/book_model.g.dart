// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 1;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      id: fields[0] as int,
      image_path: fields[1] as String,
      bookName: fields[2] as String,
      discribtion: fields[4] as String,
      pdf_path: fields[5] as String,
      genre: fields[6] as GenresModel,
      language: fields[7] as LanguageModel,
      authors: fields[3] as AuthorModel,
      isFavourite: fields[8] as bool,
      isWantToRead: fields[9] as bool,
      isFinished: fields[10] as bool,
      lastRead: fields[11] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image_path)
      ..writeByte(2)
      ..write(obj.bookName)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.discribtion)
      ..writeByte(5)
      ..write(obj.pdf_path)
      ..writeByte(6)
      ..write(obj.genre)
      ..writeByte(7)
      ..write(obj.language)
      ..writeByte(8)
      ..write(obj.isFavourite)
      ..writeByte(9)
      ..write(obj.isWantToRead)
      ..writeByte(10)
      ..write(obj.isFinished)
      ..writeByte(11)
      ..write(obj.lastRead);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
