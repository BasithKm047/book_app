
import 'package:book_app/model/admin_model.dart';
import 'package:book_app/model/author_model.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/genres_model.dart';
import 'package:book_app/model/language_model.dart';
import 'package:book_app/model/requested_book_model.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
 if(!Hive.isAdapterRegistered(BookAdapter().typeId)){
  Hive.registerAdapter(BookAdapter());

 } 

if(!Hive.isAdapterRegistered(GenresModelAdapter().typeId)){
  Hive.registerAdapter(GenresModelAdapter());
}

if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
  Hive.registerAdapter(UserModelAdapter());
}

if(!Hive.isAdapterRegistered(AuthorModelAdapter().typeId)){
  Hive.registerAdapter(AuthorModelAdapter());
}


// Hive.openBox('admin');
// Hive.openBox('user');

if(!Hive.isAdapterRegistered(LanguageModelAdapter().typeId)){
  Hive.registerAdapter(LanguageModelAdapter());
}


if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
  Hive.registerAdapter(UserModelAdapter());
}


if(!Hive.isAdapterRegistered(AdminModelAdapter().typeId)){
  Hive.registerAdapter(AdminModelAdapter());
}

if(!Hive.isAdapterRegistered(RequestedBookModelAdapter().typeId)){
  Hive.registerAdapter(RequestedBookModelAdapter());
}

// await Hive.openBox<AdminModel>('admin'); 
// await Hive.openBox(adminServices);
// await Hive.openBox('books');
// await Hive.openBox('genres');

  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: CostumColor().costum_color_6,
        appBarTheme: const AppBarTheme(centerTitle: true,color: Colors.black)
        
      
      ),
      
    
      home: const SplashScreen()
    );
  }
}