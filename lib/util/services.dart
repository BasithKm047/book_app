
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Services{
  static const String username='basith';
  static const String passWord='1234';
  
  

  Future<bool>login(String enterdusername,String enterdpassWord)async{
    if(enterdusername.trim().toLowerCase()==username&&enterdpassWord==passWord){
      final admin=Hive.box('Admin');
      await admin.put('isLoggedIn', true);
       return true;
       
    }else{
      return false;
    }


  }

  
}


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
