

import 'package:book_app/model/admin_model.dart';
import 'package:hive/hive.dart';

Future<void>addAdmin(AdminModel value)async{
  final adminDb=await Hive.openBox<AdminModel>('Admin');
  await adminDb.put(value.id, value);
  print('User added Successfully');


}


Future<void>updateAdmin(AdminModel value)async{
  final adminDb=await Hive.openBox<AdminModel>('Admin');
  if(adminDb.containsKey(value.id)){
  await adminDb.put(value.id, value);

  }
  print('Admin Updated Successfully');
  getAllAdmin(value);

}

Future<void>getAllAdmin(AdminModel value)async{
  final adminDb=await Hive.openBox<AdminModel>('Admin');
   final admin=adminDb.values.toList();
  print('Admin loaded: ${admin.map((admin) => admin.name).toList()}');

}

Future<void>deleteAdmin(AdminModel value)async{
  final adminDb=await Hive.openBox<AdminModel>('Admin');
  if(adminDb.containsKey(value.id)){
   await adminDb.delete(value.id);

  }
    print('Admin Deleted Success fully');

  getAllAdmin(value);

}