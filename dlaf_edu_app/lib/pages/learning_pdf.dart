/*import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class LearningPdfPage extends StatefulWidget {
  const LearningPdfPage({super.key});

  @override
  State<LearningPdfPage> createState() => _LearningPdfPageState();
}

class _LearningPdfPageState extends State<LearningPdfPage> {
  late PdfControllerPinch pdfControllerPinch;
  int countPages = 0, currentPage = 1;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
        document: PdfDocument.openAsset('assets/pdf/Learning_LSP.pdf'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lector PDF',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Total de páginas: ${countPages}"),
            IconButton(
              onPressed: () {
                pdfControllerPinch.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text('Página actual: ${currentPage}'),
            IconButton(
              onPressed: () {
                pdfControllerPinch.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ],
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        scrollDirection: Axis.vertical,
        controller: pdfControllerPinch,
        onDocumentLoaded: (doc) {
          setState(() {
            countPages = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LearningPdfPage extends StatefulWidget {
  const LearningPdfPage({super.key});

  @override
  State<LearningPdfPage> createState() => _LearningPdfPageState();
}

class _LearningPdfPageState extends State<LearningPdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lenguaje de Señas Peruanas (PDF)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SfPdfViewer.network(
        'https://drive.google.com/uc?export=download&id=1CV-t0wPnmRlVLvyRwre1Ing2PNr4YsdS',
        key: _pdfViewerKey,
      ),
    );
  }
}
