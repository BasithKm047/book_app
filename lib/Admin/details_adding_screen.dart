import 'dart:io';

import 'package:book_app/User/costum_textformfield.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailsAddingScreen extends StatefulWidget {
  const DetailsAddingScreen({
    super.key,
  });

  @override
  State<DetailsAddingScreen> createState() => _DetailsAddingScreenState();
}

class _DetailsAddingScreenState extends State<DetailsAddingScreen> {
  String? selectedGenre;
   List<String>genres=[
    'Fiction',
    'Science',
    'Non FIction',
    'Romantic'
  ];
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: GestureDetector(
                    onTap: () {
                      getimage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: _image != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(_image!),
                                )
                              : null,
                          color: CostumColor().costum_color_2,
                          borderRadius: BorderRadius.circular(10)),
                      height: 200,
                      width: 200,
                      child: _image == null
                          ?  Center(
                              child: Text(
                                style: CostumFontStyle(color: CostumColor().costum_color_3, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle_2(),
                                'Image'),
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                const CostumTextformfield(title: 'Book name',),
                const SizedBox(height: 15,),
                // const CostumTextformfield(title: 'Book Geners add',),
                // const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left:20,right: 20 ),
            child: Container(
              decoration: BoxDecoration(
                color: CostumColor().costum_color_2,
                borderRadius: BorderRadius.circular(10)
              ),
              child: DropdownButtonFormField(
              decoration: InputDecoration(
                
                hintStyle: CostumFontStyle(color: CostumColor().costum_color_3, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle_2(),
                hintText: 'Genres',
                fillColor: CostumColor().costum_color_3,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10),
                  
                
                // ),
                border:InputBorder.none ,
                contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              
              
              ),items: 
                genres.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value));
              
                }).toList(),
              
                
              
                
              
              
              onChanged: (value) {
                setState(() {
                  selectedGenre=value;
                });
              
              },
              
              
                
              ),
            ),
          ),
          const SizedBox(height: 20,),

          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              color: CostumColor().costum_color_2,
              borderRadius: BorderRadius.circular(10),
            
              
            ),
            child: TextFormField(
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(

                
                hintText: 'Discribtion',
                hintStyle: CostumFontStyle(color: CostumColor().costum_color_3, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle_2()
              ),
            ),
            
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: CostumColor().costum_color_2,width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.upload),),
                  ),
                  Text(
                    style: CostumFontStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal).getFontstyle_2(),
                    'Add Pdf')
                ],
              ),
            ),
          ),
          const SizedBox(height: 30,),

          SizedBox(
            height: 50,
            width: 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: CostumColor().costum_color,

                
              ),
              
              onPressed: (){
              // save data
            }, child: Text(
              style: CostumFontStyle(color: CostumColor().costum_color_1, fontSize: 15, fontWeight: FontWeight.w400).getFontstyle(),
              'Save'),
            ),
          ),

          const SizedBox(height: 30,)

                
              ],
            ),
            
          ),
        ],
      ),
    );
  }

  Future<void> getimage() async {
    final selectedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedimage == null) return;
    final imageTemborory = File(selectedimage.path);

    setState(() {
      _image = imageTemborory;
    });
  }

  Future<void>pickPdfFile()async{
    FilePickerResult? result=await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if(result!=null){
      PlatformFile file=result.files.first;
      // print('selected file:${file.name}');
      print('File path:${file.path}');
    }else{
      // print('No File Selected');
    }

  }

 
}
