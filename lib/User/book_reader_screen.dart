

import 'dart:async';

import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hive_flutter/adapters.dart';

class BookReaderScreen extends StatefulWidget {
  final String pdf_path;
  final Book book;
  const BookReaderScreen({
    super.key, required this.pdf_path, required this.book,
  });

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  late Timer _timer;
  int secondsRead=0;

  String? pdfPath;
  int currentPage=0;
  int totalPage=0;
  bool pdfReady=false;
  late PDFViewController pdfViewController;

   

  @override
  void initState() {
    super.initState();
    // loadPdfFromAsset();
    setState(() {
      pdfPath=widget.pdf_path;
     
    });
    savedReadingProgress(currentPage);
    //  recentlyReadBookFunction(widget.book);
    //  getRecentlyReadBooks(wi);
    startReadingTimer();
  }

void startReadingTimer(){
  _timer=Timer.periodic(const Duration(seconds: 1),(timer) {
    setState(() {
      secondsRead++;
    });
  },);
}

double getReadingprgress(){
  double targetTime=widget.book.targetTimeInsecond.toDouble();
  double progress=(secondsRead / targetTime)*100;
  return progress>100?100:progress;
}


void stopReadingTimer(){
  _timer.cancel();
  updateBookReadingTime();
}



Future<void>updateBookReadingTime()async{
  final bookDb=await Hive.openBox<Book>('books');
  Book book=widget.book;
  book.readingTimeInsecond=secondsRead;
  await bookDb.put(book.id, book);
  print('Book reading time updated: ${book.readingTimeInsecond}');
}

@override
  void dispose() {
    super.dispose();
    startReadingTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(
          color: Colors.white,
          Icons.arrow_back)),
      ),
      
       body: pdfPath != null
          ? Stack(
            children: [
             
              PDFView(
                
                fitEachPage: true,
                filePath: pdfPath,
                swipeHorizontal: true,
                pageFling: true,
                fitPolicy: FitPolicy.HEIGHT,
                autoSpacing: true,
                enableSwipe: true,
                nightMode: true,
              onRender: (pages) {
                setState(() {
                  totalPage=pages!;
                pdfReady=true;
                });
                
              },
              onViewCreated: (controller) {
                setState(() {
                  pdfViewController=controller;
                });
                
              },
              onPageChanged: (page, total) {
                setState(() {
                  currentPage=page!;
                });
                savedReadingProgress(page!);
              },
                    
              
              
              ),
               Positioned(
                // left: 20,
                bottom: 330,

                child: IconButton(onPressed: ()async{
                  if(currentPage>0){
                  await  pdfViewController.setPage(currentPage-1);

                    setState(() {
                      currentPage-=1;
                    });
                  }
                }, icon: const Icon(
                  color: Colors.white,
                  Icons.arrow_back_ios)),
              ),

              Positioned(
                right: 1,
                bottom: 330,
                child: IconButton(onPressed: ()async{
                  if(currentPage<totalPage-1){
                  await pdfViewController.setPage(currentPage+1);

                    setState(() {
                      currentPage+=1;
                    });
                  }
                }, icon: const Icon(
                  color: Colors.white,
                  Icons.arrow_forward_ios)),
              )

            ] ,
          )
            //  canShowPageLoadingIndicator: true,
         
          : const Center(child: CircularProgressIndicator()),
    
    );
  }
  void savedReadingProgress(int currentPage)async{
      widget.book.currentPage=currentPage;
      final bookDb=await Hive.openBox<Book>('books');
      await bookDb.put(widget.book.id, widget.book);
      bookListnotifier.notifyListeners();
      
  }
  
// double getReadeProgress(Book book){
//      double progress=(book.currentPage/(book.totalPage>0?book.totalPage:1)).clamp(0.0, 1.0);
//     return progress;
//   }
}
