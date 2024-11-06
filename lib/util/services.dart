
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Services{
  static const String username='basith';
  static const String passWord='1234';
  
  

  Future<bool>adminlogin(String enterdusername,String enterdpassWord)async{
    if(enterdusername.trim().toLowerCase()==username&&enterdpassWord==passWord){
      final admin=Hive.box('admin');
      await admin.put('isLoggedIn', true);
       return true;
       
    }else{
      return false;
    }


  }

Future<bool>userLogin(String username )async{
  if(username.isNotEmpty){
    final user=await Hive.openBox('user');
        await user.put('isLoggedIn', true);
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
