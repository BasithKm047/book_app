

import 'package:book_app/model/admin_model.dart';
import 'package:hive/hive.dart';


// Function to add an Admin
Future<void> addAdmin(AdminModel value) async {
  try {
    final adminDb = await Hive.openBox<AdminModel>('admin');
    await adminDb.put(value.id, value);
    print('Admin added successfully');
  } catch (e) {
    print('Error adding admin: $e');
    // You can handle the error or show an error dialog if needed
    // showErrorDialog('Failed to save admin details. Please try again.');
  }
}

// Function to get the Admin box
Future<Box<AdminModel>> getAdminBox() async {
  if (Hive.isBoxOpen('admin')) {
    return Hive.box<AdminModel>('admin');
  } else {
    return await Hive.openBox<AdminModel>('admin');
  }
}

// Function to fetch all Admins from the Box
Future<List<AdminModel>> getAllAdmin() async {
  try {
    final adminDb = await getAdminBox();  // Using getAdminBox to get the opened box
    final adminList = adminDb.values.toList();
    print('Admins loaded: ${adminList.map((admin) => admin.name).toList()}');
    return adminList;
  } catch (e) {
    print('Error loading admins: $e');
    return [];  // Return an empty list in case of an error
  }
}

// Function to update an Admin
Future<void> updateAdmin(AdminModel value) async {
  try {
    final adminDb = await getAdminBox();  // Using the helper function to get the box
    if (adminDb.containsKey(value.id)) {
      await adminDb.put(value.id, value);
      print('Admin updated successfully');
    } else {
      print('Admin not found to update');
    }
  } catch (e) {
    print('Error updating admin: $e');
  }
}

// Function to delete an Admin
Future<void> deleteAdmin(AdminModel value) async {
  try {
    final adminDb = await getAdminBox();  // Using the helper function to get the box
    if (adminDb.containsKey(value.id)) {
      await adminDb.delete(value.id);
      print('Admin deleted successfully');
    } else {
      print('Admin not found to delete');
    }
  } catch (e) {
    print('Error deleting admin: $e');
  }
}

// Function to save Admin data (e.g., username and image)
Future<void> saveAdminData(String username, String imagePath) async {
  final box = await Hive.openBox('admin_data');
  await box.put('username', username);
  await box.put('image', imagePath);
  print('Admin data saved successfully');
}




// Future<void>updateAdmin(AdminModel value)async{
//   final adminDb=await Hive.openBox<AdminModel>('Admin');
//   if(adminDb.containsKey(value.id)){
//   await adminDb.put(value.id, value);

//   }
//   print('Admin Updated Successfully');
//   getAllAdmin(value);

// }



// Future<void>deleteAdmin(AdminModel value)async{
//   final adminDb=await Hive.openBox<AdminModel>('Admin');
//   if(adminDb.containsKey(value.id)){
//    await adminDb.delete(value.id);

//   }
//     print('Admin Deleted Success fully');

//   getAllAdmin(value);

// }

// Future<void> saveAdminData(String username, String imagePath) async {
//   final box = await Hive.openBox('admin_data');
  
//   await box.put('username', username);
//   await box.put('image', imagePath);
// }
