import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class BookReaderScreen extends StatefulWidget {
  const BookReaderScreen({
    super.key,
  });

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  String? localpath;
  int currentPage=0;
  int totalPage=0;
  bool pdfReady=false;
  late PDFViewController pdfViewController;

  Future<void> loadPdfFromAsset() async {
    try {
      final byteData =
          await rootBundle.load('Asset/Books/the_girl_who_lept.pdf');
      final fil =
          File('${(await getTemporaryDirectory()).path}/the_girl_who_lept.pdf');
      await fil.writeAsBytes(byteData.buffer.asInt8List(), flush: true);

      setState(() {
        localpath = fil.path;
      });
    } catch (e) {
      print('Error Loading PDF:$e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadPdfFromAsset();
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
      
       body: localpath != null
          ? Stack(
            children: [
             
              PDFView(
                fitEachPage: true,
                filePath: localpath,
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
              },
                    
              
              
              ),
              //  Positioned(
              //   // left: 20,
              //   bottom: 330,

              //   child: IconButton(onPressed: ()async{
              //     if(currentPage>0){
              //     await  pdfViewController.setPage(currentPage-1);

              //       setState(() {
              //         currentPage-=1;
              //       });
              //     }
              //   }, icon: const Icon(
              //     color: Colors.white,
              //     Icons.arrow_back_ios)),
              // ),

              // Positioned(
              //   right: 1,
              //   bottom: 330,
              //   child: IconButton(onPressed: ()async{
              //     if(currentPage<totalPage-1){
              //     await pdfViewController.setPage(currentPage+1);

              //       setState(() {
              //         currentPage+=1;
              //       });
              //     }
              //   }, icon: const Icon(
              //     color: Colors.white,
              //     Icons.arrow_forward_ios)),
              // )

            ] ,
          )
            //  canShowPageLoadingIndicator: true,
         
          : const Center(child: CircularProgressIndicator()),
    
    );
  }
}
