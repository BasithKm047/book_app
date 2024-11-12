import 'package:book_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier <List<UserModel>>userList_notifier=ValueNotifier([]);

 String userBox='user';

  
// Future<void>addUser(UserModel value)async{
//   userList_notifier.value.add(value);
//   final userDb=await Hive.openBox<UserModel>('UserDetails');
//   await userDb.put(value.id, value);
//   print('User added Successfully');


// }

// Future<void> updateUser(UserModel value) async {
//     final userDb = await Hive.openBox<UserModel>('UserDetails');
//     if (userDb.containsKey(value.id)) {
//       await userDb.put(value.id, value);
//     }
//     print('User Updated Successfully');
//     getAllUser();
//   }

//   Future<void>deleteUser(UserModel value)async{
//     final userDb=await Hive.openBox<UserModel>('UserDetails');
//     if(userDb.containsKey(value.id)){
//       await userDb.delete(value.id);
//     }
//     print('user Deleted Success fully');
//     getAllUser();

//   }

//   Future<void>getAllUser()async{
//       final userDb=await Hive.openBox<UserModel>('UserDetails');
//       final user=userDb.values.toList();
//       userList_notifier.value.toList();
//   print('User loaded: ${user.map((user) => user.username).toList()}');





//   }
Future<void>addUser(UserModel user)async{
  try {
    final adminDb = await Hive.openBox<UserModel>(userBox);
    await adminDb.put(user.id, user);
    userList_notifier.notifyListeners();
    print('Admin added: ${user.username}');
    print('Admin added successfully');
  } catch (e) {
    print('Error adding admin: $e');
    // You can handle the error or show an error dialog if needed
    // showErrorDialog('Failed to save admin details. Please try again.');
  }

}

Future<List> getUserdetails()async{
  final adminDb=await Hive.openBox<UserModel>(userBox);
  final adminList=adminDb.values.toList();
  userList_notifier.value=adminList;
  userList_notifier.notifyListeners();

  return adminList;
}



// Future<void> saveUserData(String username, String imagePath) async {
//   final box = await Hive.openBox('user_data');
  
//   await box.put('username', username);
//   await box.put('image', imagePath);
// }

