import 'dart:io';

import 'package:book_app/Admin/details_adding_screen.dart';
import 'package:book_app/function/author_db_function.dart';
import 'package:book_app/model/author_model.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:book_app/util/media_querry.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthorAddingScreen extends StatefulWidget {
  const AuthorAddingScreen({super.key});

  @override
  State<AuthorAddingScreen> createState() => _AuthorAddingScreenState();
}

class _AuthorAddingScreenState extends State<AuthorAddingScreen> {
  TextEditingController _authorNameController=TextEditingController();
  File ?_authorImage;
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title:  Text(
        style: CostumFontStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400).getFontstyle(),
        'Add author'),),

        body: Center(
          child: Container(
            height: ResponsiveHelper(context).getResponsiveHeight(50),
            width: ResponsiveHelper(context).getResponsiveWidth(90),
            decoration: BoxDecoration(
            color: CostumColor().costum_color_3,
            // border: Border.all(color: CostumColor().costum_color_1)
            borderRadius: BorderRadius.circular(15)

            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      getAuthorimage();
                    },
                    child: Container(
                      
                      height: ResponsiveHelper(context).getResponsiveHeight(15),
                      width: ResponsiveHelper(context).getResponsiveWidth(35),
                      decoration: BoxDecoration(
                        image: 
                        DecorationImage(
                          fit: BoxFit.cover,
                          image:_authorImage!=null? FileImage(_authorImage!):const AssetImage(
                          
                          'Asset/download_1.jpeg')),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      
                      
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
              
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _authorNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                        gapPadding: BorderSide.strokeAlignCenter,
                        ),
                        
                        labelText: 'Author name',
                        labelStyle: CostumFontStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle_2(),
                    
                    
                      ),
                     validator: (value) {
                       if(value!.isEmpty){
                        return 'Enter a name';
                       }
                       return null;
                     },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
              
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(ResponsiveHelper(context).getResponsiveWidth(80), 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
              
                      ),
                      backgroundColor: CostumColor().costum_color_1
                    ),
                    onPressed: addAuthor,
                     child: Text(
                      style: CostumFontStyle(color: CostumColor().costum_color_3, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle_2(),
                      'Add author'),
                      ),
                      const SizedBox(height: 15,)
              
                ],
              ),
            ),
          ),
        ),
    );
  }
   Future<void> addAuthor() async {
    if (_formKey.currentState!.validate()) {
      if (_authorImage != null) {
        int authorId = createUniqueId();
        final author = AuthorModel(
          authorId,
          _authorNameController.text,
          _authorImage!.path,
        );

        await addAuthortoDb(author);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DetailsAddingScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an author image')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required details')),
      );
    }
  }
   Future<void> getAuthorimage() async {
    final selectedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedimage == null) return;
    final imageTemborory = File(selectedimage.path);

    setState(() {
      _authorImage = imageTemborory;
    });
    print('image added success');
  }

}