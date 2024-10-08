
import 'package:book_app/User/welcome_screen.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/genres_model.dart';
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

// await Hive.openBox('books');
// await Hive.openBox('genres');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
      
      ),
      home: const WelcomeScreen()
    );
  }
}