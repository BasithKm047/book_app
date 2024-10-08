
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class BookReaderScreen extends StatefulWidget {
  final String pdf_path;
  const BookReaderScreen({
    super.key, required this.pdf_path,
  });

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  String? pdfPath;
  int currentPage=0;
  int totalPage=0;
  bool pdfReady=false;
  late PDFViewController pdfViewController;

  // Future<void> loadPdfFromAsset() async {
  //   try {
  //     final byteData =
  //         await rootBundle.load(widget.pdf_path);
  //     final file =
  //         File('${(await getTemporaryDirectory()).path}/${widget.pdf_path.split('/').last}');
  //     await file.writeAsBytes(byteData.buffer.asInt8List(), flush: true);

  //     setState(() {
  //       localpath = file.path;
  //     });
  //   } catch (e) {
  //     print('Error Loading PDF:$e');
  //   }
  // }

  // Future<void>pickPdf()async{
  //   FilePickerResult? result=await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //   if(result!=null&& result.files.isNotEmpty){
  //     pdfPath=result.files.single.path;
  //   }
  // }
  

  @override
  void initState() {
    super.initState();
    // loadPdfFromAsset();
    setState(() {
      pdfPath=widget.pdf_path;
    });
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
