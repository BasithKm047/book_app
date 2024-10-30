import 'package:book_app/model/author_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<AuthorModel>> author_modelList = ValueNotifier([]);

Future<void> addAuthortoDb(AuthorModel value) async {
  final authorDb = await Hive.openBox<AuthorModel>('author');
  await authorDb.put(value.id, value);
  print('Author  added succesfully${value.name}');
  author_modelList.notifyListeners();
getAllAuthor();
}

Future<List<AuthorModel>> getAllAuthor() async {
  final authorDb = await Hive.openBox<AuthorModel>('author');
  final getAuthor = authorDb.values.toList();
  author_modelList.value = getAuthor;
  print('Author Loaded ${getAuthor.map((val) => val.name).toSet().toList()}');
  author_modelList.notifyListeners();
  return getAuthor;
}

Future<void> deleteAuthor(AuthorModel value) async {
  final authorDb = await Hive.openBox<AuthorModel>('author');
  await authorDb.delete(value.id);
  print('Author Deleted SucesFully');
  getAllAuthor();
}

Future<void>updateAuthor(AuthorModel value )async{
  final authorDb=await Hive.openBox<AuthorModel>('author');
     await authorDb.put(value.id, value);
     getAllAuthor();
    print('Author Updateded Succesfully');

      
  }

 