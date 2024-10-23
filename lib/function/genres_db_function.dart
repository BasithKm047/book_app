import 'package:book_app/model/genres_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
ValueNotifier <List<GenresModel>>  genremodelList= ValueNotifier([]);

  Future<void>addGenres(GenresModel value)async{
    genremodelList.value.add(value);
    final genreDb=await Hive.openBox<GenresModel>('genres');
    await genreDb.put( value.id, value);
    // await genreDb.add(value);
    print('Genre added succesfully');
    genremodelList.notifyListeners();

    getAllGenres();
    
  }

Future<void>updateGeners(GenresModel value )async{
  final genredb=await Hive.openBox<GenresModel>('genres');
     await genredb.put(value.id, value);
     getAllGenres();
    print('Genre Updateded Succesfully');

      
  }



Future<void>deletGenres(GenresModel value)async{
  final genreDb=await Hive.openBox<GenresModel>('genres');
   await genreDb.delete(value.id);
   print('deleted succesfully');
  // final genreKey=genreDb.keys.firstWhere((key){
  //   final  genre=genreDb.get(key)as GenresModel;
  //   return genre.id==value.id ;
  // },orElse: ()=>null);

  // if(genreKey!=null){
  //     await genreDb.delete(genreKey);
  //     print('Dleted genre With id ${value.id}');
  // }else{
  //   print('genre not found');
  // }

  await getAllGenres();


  }


Future<void>getAllGenres()async{
  final genreDb=await Hive.openBox<GenresModel>('genres');
  final genres = genreDb.values.toList();
  genremodelList.value=genres;
  print('Genres loaded: ${genres.map((g) => g.name).toList()}');
  genremodelList.notifyListeners();
   
}
