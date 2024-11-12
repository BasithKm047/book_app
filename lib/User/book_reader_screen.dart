

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
    secondsRead=widget.book.readingTimeInsecond;
      pdfPath=widget.pdf_path;
      currentPage=widget.book.currentPage;
      totalPage=widget.book.totalPage;
    // savedReadingProgress(currentPage, totalPage: totalPage);
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
void onBackPressed() async {
    stopReadingTimer(); // Stop the timer
    await savedReadingProgress(currentPage); // Save current reading progress
    Navigator.of(context).pop(); // Navigate back
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
    stopReadingTimer();
    savedReadingProgress(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        onBackPressed();
        return false;
      },
      child: Scaffold(
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
                  fitPolicy: FitPolicy.BOTH,
                  autoSpacing: true,
                  enableSwipe: true,
                  nightMode: true,
                onRender: (pages)async {
                  setState(() {
                    totalPage=pages!;
                  pdfReady=true;
                  });
                  if(widget.book.totalPage!=totalPage){
                   await savedReadingProgress(currentPage,totalPage: totalPage);
                  }
                  
                },
                onViewCreated: (controller) {
                setState(() {
                   pdfViewController=controller;
                   pdfViewController.setPage(currentPage);
                });
                   
      
                  
                  
                },
                onPageChanged: (page, total) async{
                  setState(() {
                    currentPage=page!; 
                  });
                await  savedReadingProgress(currentPage,);
                },
                      
                
                
                ),
                 Positioned(
                  bottom: 330,
      
                  child: IconButton(onPressed: ()async{
                    if(currentPage>0){
                    await  pdfViewController.setPage(currentPage-1);
      
                      setState(() {
                        currentPage-=1;
                      });
                    }
                    await savedReadingProgress(currentPage);
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
      
      ),
    );
  }
  Future<void> savedReadingProgress(int currentPage , {int ?totalPage})async{
      widget.book.currentPage=currentPage;
      if(totalPage!=null){
        widget.book.totalPage=totalPage;
      }
      final bookDb=await Hive.openBox<Book>('books');
      await bookDb.put(widget.book.id, widget.book);
      bookListnotifier.notifyListeners();
      
  }
  

}
