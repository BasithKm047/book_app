import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:book_app/model/book_model.dart';

class BookReaderScreen extends StatefulWidget {
  final String pdfPath; // Either a file path (mobile) or Base64 (web)
  final Book book; // Book object containing currentPage and other details
  final int currentPage; // Starting page for the book

  const BookReaderScreen({
    Key? key,
    required this.pdfPath,
    required this.book,
    required this.currentPage,
  }) : super(key: key);

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  late int currentPage;
  int totalPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.book.currentPage;
    _initializeReadingProgress();
  }

  /// Loads the reading progress from Hive.
  Future<void> _initializeReadingProgress() async {
    final bookDb = await Hive.openBox<Book>('books');
    final storedBook = bookDb.get(widget.book.id);

    if (storedBook != null) {
      setState(() {
        currentPage = storedBook.currentPage;
      });
    }
  }

  /// Saves the current page and total pages to Hive.
  Future<void> _saveReadingProgress() async {
    widget.book.currentPage = currentPage;
    widget.book.totalPage = totalPage;

    final bookDb = await Hive.openBox<Book>('books');
    await bookDb.put(widget.book.id, widget.book);
  }

  /// Handles page change events in the PDF viewer.
  void _onPageChanged(PdfPageChangedDetails details) {
    setState(() {
      currentPage = details.newPageNumber;
    });
    _saveReadingProgress();
  }

  /// Handles the document load event to update the total page count.
  void _onDocumentLoaded(PdfDocumentLoadedDetails details) {
    setState(() {
      totalPage = details.document.pages.count;
    });
    _pdfViewerController.jumpToPage(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Page $currentPage of $totalPage",
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              if (currentPage > 1) {
                _pdfViewerController.previousPage();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: () {
              if (currentPage < totalPage) {
                _pdfViewerController.nextPage();
              }
            },
          ),
        ],
      ),
      body: _buildPdfViewer(),
    );
  }

  /// Builds the PDF Viewer based on the platform (Web/Mobile).
  Widget _buildPdfViewer() {
    if (widget.pdfPath.isEmpty) {
      return const Center(
        child: Text(
          "PDF not available.",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return kIsWeb
        ? _buildWebPdfViewer()
        : _buildMobilePdfViewer();
  }

  /// Builds the PDF Viewer for the web platform.
  Widget _buildWebPdfViewer() {
    try {
      return SfPdfViewer.memory(
        base64Decode(widget.pdfPath),
        controller: _pdfViewerController,
        onPageChanged: _onPageChanged,
        onDocumentLoaded: _onDocumentLoaded,
      );
    } catch (e) {
      return _buildErrorMessage("Failed to load PDF for the web.");
    }
  }

  /// Builds the PDF Viewer for mobile platforms.
  Widget _buildMobilePdfViewer() {
    try {
      return SfPdfViewer.file(
        File(widget.pdfPath),
        controller: _pdfViewerController,
        onPageChanged: _onPageChanged,
        onDocumentLoaded: _onDocumentLoaded,
      );
    } catch (e) {
      return _buildErrorMessage("Failed to load PDF on mobile.");
    }
  }

  /// Returns an error message widget.
  Widget _buildErrorMessage(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }
}
