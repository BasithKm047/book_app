import 'package:book_app/model/language_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<LanguageModel>> languageModelList = ValueNotifier([]);

Future<void> addLanguage(LanguageModel value) async {
  final languageDb = await Hive.openBox<LanguageModel>('Language');
  await languageDb.put(value.id, value);
  print('Language added successfully');
  languageModelList.notifyListeners();

  getAllLanguage();
}

Future<List<LanguageModel>> getAllLanguage() async {
  final langugeDb = await Hive.openBox<LanguageModel>('Language');
  final language = langugeDb.values.toList();
  languageModelList.value=language;
  print('Language Loaded:${language.map((lan) => lan.language).toList()}');
  languageModelList.notifyListeners();
  return language;
}

Future<void>deleteLanguage(LanguageModel values)async{
  final languageDb=await Hive.openBox<LanguageModel>('Language');
  languageDb.delete(values.id);
  print('Language deleted Successfully');
  getAllLanguage();
}

Future<void>updateLanguage(LanguageModel values)async{
  final languageDb=await Hive.openBox<LanguageModel>('Language');
  languageDb.put(values.id, values);
  print('Langauge Updated Succesfully');
  getAllLanguage();
}