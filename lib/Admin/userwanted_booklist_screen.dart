import 'package:book_app/function/requestbook_db_function.dart';
import 'package:book_app/util/common_function.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';

class UserWantedBookList extends StatelessWidget {
  const UserWantedBookList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: CostumFontStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)
                .getFontstyle(),
            'List of Books'),
      ),
      body: const RequestBookListanbleBuilder(),
    );
  }
}

class RequestBookListanbleBuilder extends StatelessWidget {
  const RequestBookListanbleBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    getRequestedBooks();
    return ValueListenableBuilder(
      valueListenable: requestBookList ,
      builder: (context, listOfBooks, child) {
        if(listOfBooks.isEmpty){
          return Center( child: Text('No request Books available',
          style: CostumFontStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal).getFontstyle(),),);

        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final book = listOfBooks[index];
              return ListTile(
                title: Text(
                    style: CostumFontStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)
                        .getFontstyle(),
                    book.bookName),
                    trailing: IconButton(onPressed: (){
                      showDialog(context: context, builder: (context) {
                        return alertDialogForDelete(context: context, itemDetails: book, itemType: book.bookName, deleteFunction: deleteRequestedBook);
                      },);

                    }, icon: const Icon(
                      color: Colors.red,
                      Icons.delete)),
              );
            },
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            itemCount: listOfBooks.length,
        
          ),
        );
      },
    );
  }
}
