import 'package:book_app/User/navigator_screen.dart';
import 'package:book_app/User/user_details_screen.dart';
import 'package:book_app/function/requestbook_db_function.dart';
import 'package:book_app/model/requested_book_model.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestBookState extends State<RequestBook> {
  TextEditingController _bookName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Request a book',
            style: CostumFontStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)
                .getFontstyle(),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: CostumColor().costum_color_2,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z]')), // Restrict to letters only
                  ],
                  controller: _bookName,
                  decoration: InputDecoration(
                      isDense: true,
                      hintStyle: CostumFontStyle(
                              color: CostumColor().costum_color_3,
                              fontSize: 15,
                              fontWeight: FontWeight.normal)
                          .getFontstyle_2(),
                      hintText: 'Request a book',
                      fillColor: CostumColor().costum_color_2,
                      // border: OutlineInputBorder(
                      //     // gapPadding: 10,

                      //     borderRadius: BorderRadius.circular(10)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10)),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CostumColor().costum_color,
                  elevation: 5,
                ),
                onPressed: () {
                  requestBook();
                },
                child: Text(
                    style: CostumFontStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal)
                        .getFontstyle_2(),
                    'Request'))
          ],
        ),
      ),
    );
  }

  Future<void> requestBook() async {
    _bookName.text.toLowerCase().trim();
   int newId=createUniqueId();
   final newRequestBook= RequestedBookModel(id: newId, bookName: _bookName.text);
   await addRequestedBook(newRequestBook);
    
    Dailogueforlottie(context,'Book requested successfully');
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavigatorScreen(),));

  }

 
}