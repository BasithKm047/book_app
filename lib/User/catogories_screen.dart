import 'package:book_app/util/book_card.dart';
import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/util/costum_color.dart';
import 'package:book_app/util/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class CatogoriesScreen extends StatefulWidget {
  final String title;
  final bool isAdmin;
  final bool isLanguage;
  final bool isAUthor;
  final bool isGenre;
  const CatogoriesScreen(
      {super.key,
      required this.title,
      required this.isAdmin,
      required this.isLanguage,
      required this.isAUthor,
      required this.isGenre});

  @override
  State<CatogoriesScreen> createState() => _CatogoriesScreenState();
}

class _CatogoriesScreenState extends State<CatogoriesScreen> {
  @override
  void initState() {
    super.initState();
   loadData();
  }

Future<void> loadData() async {
  await getBooksByGenre(widget.title);
  await getBookByLanguage(widget.title);
  await getBookByAuthor(widget.title);
}

  Widget buildBookGrid(List<Book> bookDetails) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.50,
      ),
      itemCount: bookDetails.length,
      itemBuilder: (context, index) {
        final book = bookDetails[index];
        return BookCard(
          imagePath: book.image_path,
          title: book.bookName,
          isAdmin: widget.isAdmin,
          icon: const Icon(Icons.delete),
          icon_2: const Icon(Boxicons.bx_edit),
          isLanguage: widget.isLanguage,
          // onDelete: (book) => deleteBook(book),
          // onUpdate: () => updateBooks,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CostumColor().costum_color_6,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CostumColor().costum_color_6,
        title: Text(
            style: CostumFontStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)
                .getFontstyle(),
            widget.title),
      ),
      body: ValueListenableBuilder<List<Book>>(
        valueListenable: widget.isAUthor
            ? bookListbyAuthor
            : widget.isLanguage
                ? bookListByLanguage
                : widget.isGenre
                    ? bookListbyGenreNotifier
                    : ValueNotifier<List<Book>>([]),
        builder: (context, List<Book> bookDetails, child) {
          return bookDetails.isEmpty
              ? const Center(
                  child: Text('No books Found'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildBookGrid(bookDetails),
                );
        },
      ),
    );
  }
  
}
