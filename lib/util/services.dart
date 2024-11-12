import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

String adminServices = 'user_details';
String userServices = 'user_details';

class Services {
  static const String username = 'basith';
  static const String passWord = '1234';

  Future<bool> adminlogin(String enterdusername, String enterdpassWord) async {
    final adminBox=await Hive.openBox(adminServices);
    try {
      if (enterdusername.trim().toLowerCase() == username &&
          enterdpassWord == passWord) {
        await adminBox.put('isLoggedIn', true);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error in adminlogin: $e');
      return false;
    }
  }

  Future<bool> userLogin(String username) async {
     final UserBox=await Hive.openBox(userServices);
    if (username.isNotEmpty) {
      await UserBox.put('isLoggedIn', true);
      return true;
    } else {
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
