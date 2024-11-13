import 'dart:async';

import 'package:book_app/function/book_db_function.dart';
import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hive_flutter/adapters.dart';

class BookReaderScreen extends StatefulWidget {
  final String pdf_path;
  final Book book;
  final int currentPage;
  const BookReaderScreen({
    super.key,
    required this.pdf_path,
    required this.book, required this.currentPage,
  });

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  // late Timer _timer;
  int secondsRead = 0;

  String? pdfPath;
  int currentPage = 0;
  int totalPage = 0;
  bool pdfReady = false;
  late PDFViewController pdfViewController;

  @override
  void initState() {
    super.initState();
    // loadPdfFromAsset();
    secondsRead = widget.book.readingTimeInsecond;
    pdfPath = widget.pdf_path;
    currentPage = widget.book.currentPage;
    totalPage = widget.book.totalPage;
    // savedReadingProgress(currentPage, totalPage: totalPage);
    //  recentlyReadBookFunction(widget.book);
    //  getRecentlyReadBooks(wi);
    // startReadingTimer();
    print("initState: secondsRead = $secondsRead");
    print("initState: pdfPath = $pdfPath");
    print("initState: currentPage = $currentPage, totalPage = $totalPage");
    loadingprogress();
  }

  Future<void> loadingprogress() async {
    final bookDb = await Hive.openBox('books');
    Book? savedBoook = bookDb.get(widget.book.id);
    if (savedBoook != null) {
      setState(() {
        widget.book.currentPage = savedBoook.currentPage;
        currentPage = widget.book.currentPage;
        totalPage - savedBoook.totalPage;
      });
      print("Restored reading progress: Page $currentPage of $totalPage");
    } else {
      print("No saved progress found. Starting from page 0.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(color: Colors.white, Icons.arrow_back)),
        title: Text(
          '$currentPage of $totalPage',
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) async {
          if (details.primaryVelocity! < 0 && currentPage < totalPage - 1) {
            currentPage++;
    
            pdfViewController.setPage(currentPage);
            await savedReadingProgress(currentPage);
          } else if (details.primaryVelocity! > 0 && currentPage > 0) {
            currentPage--;
            pdfViewController.setPage(currentPage);
            await savedReadingProgress(currentPage);
          }
        },
        child: pdfPath != null
            ? Stack(
                children: [
                  PDFView(
                    fitEachPage: true,
                    filePath: pdfPath,
                    swipeHorizontal: true,
                    pageFling: true,
                    fitPolicy: FitPolicy.WIDTH,
                    autoSpacing: true,
                    enableSwipe: true,
                    nightMode: true,
                    onRender:   (pages) async {
                      setState(() {
                        totalPage = pages!;
                        pdfReady = true;
                      });
                      print(
                          "PDF Rendered: Total pages = $totalPage, pdfReady = $pdfReady");
                      if (pdfReady && pdfViewController != null) {
                        print("Setting current page to: ${widget.currentPage}");
                        pdfViewController.setPage(widget.currentPage);
                      }else{
                         print("Waiting for PDFViewController to be ready...");
                      }
                      if (widget.book.totalPage != totalPage) {
                        await savedReadingProgress(currentPage,
                            totalPage: totalPage);
                      }
                    },
                    onViewCreated: (controller) {
                      pdfViewController = controller;
                      print("PDFViewController initialized.");
                      if (pdfReady) {
                        print(
                            "PDF is ready. Setting initial page to: $currentPage");
                        pdfViewController.setPage(currentPage);
                      } else {
                        print("PDF is not ready yet.");
                      }
                    },
                    onPageChanged: (page, total) async {
                      setState(() {
                        currentPage = page!;
                      });
                      await savedReadingProgress(
                        currentPage,
                      );
                    },
                  ),
                  Positioned(
                    left: 1,
                    bottom: 330,
                    child: IconButton(
                        onPressed: () async {
                          if (currentPage > 0) {
                            await pdfViewController.setPage(currentPage);
    
                            setState(() {
                              currentPage -= 1;
                            });
                          }
                          await savedReadingProgress(currentPage);
                        },
                        icon: const Icon(
                            color: Colors.white, Icons.arrow_back_ios)),
                  ),
    
                  Positioned(
                    right: 1,
                    bottom: 330,
                    child: IconButton(
                        onPressed: () async {
                          if (currentPage < totalPage - 1) {
                            await pdfViewController.setPage(currentPage);
    
                            setState(() {
                              currentPage += 1;
                            });
                          }
                        },
                        icon: const Icon(
                            color: Colors.white, Icons.arrow_forward_ios)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
    
                  // Positioned(
                  //   right: 160,
                  //   top: 10,
                  //   child: Text('$currentPage of $totalPage',
                  //   style:  const TextStyle(color: Colors.white,fontSize: 10),),
                  // )
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> savedReadingProgress(int currentPage, {int? totalPage}) async {
    widget.book.currentPage = currentPage;
    if (totalPage != null) {
      widget.book.totalPage = totalPage;
    }
    final bookDb = await Hive.openBox<Book>('books');
    await bookDb.put(widget.book.id, widget.book);
    bookListnotifier.notifyListeners();
  }
}

 // void startReadingTimer() {
  //   _timer = Timer.periodic(
  //     const Duration(seconds: 1),
  //     (timer) {
  //       setState(() {
  //         secondsRead++;
  //       });
  //     },
  //   );
  // }

  // void onBackPressed() async {
  //   // stopReadingTimer(); // Stop the timer
  //   await savedReadingProgress(currentPage); // Save current reading progress
  //   Navigator.of(context).pop(); // Navigate back
  // }

  // double getReadingprgress() {
  //   double targetTime = widget.book.targetTimeInsecond.toDouble();
  //   double progress = (secondsRead / targetTime) * 100;
  //   return progress > 100 ? 100 : progress;
  // }

  // void stopReadingTimer() {
  //   _timer.cancel();
  //   updateBookReadingTime();
  // }

  // Future<void> updateBookReadingTime() async {
  //   final bookDb = await Hive.openBox<Book>('books');
  //   Book book = widget.book;
  //   book.readingTimeInsecond = secondsRead;
  //   await bookDb.put(book.id, book);
  //   print('Book reading time updated: ${book.readingTimeInsecond}');
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   stopReadingTimer();
  //   savedReadingProgress(currentPage);
  // }