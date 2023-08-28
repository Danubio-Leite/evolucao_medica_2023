// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWid;
import 'package:printing/printing.dart';

class PDFViewPage extends StatefulWidget {
  Map currentItem;
  PDFViewPage({Key? key, required this.currentItem}) : super(key: key);

  @override
  _PDFViewState createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (format) => _createPdf(
          format,
        ),
      ),
    );
  }

  Future<Uint8List> _createPdf(
    PdfPageFormat format,
  ) async {
    final pdf = pdfWid.Document(
      version: PdfVersion.pdf_1_4,
      compress: true,
    );
    pdf.addPage(
      pdfWid.Page(
        pageFormat: PdfPageFormat((80 * (72.0 / 25.4)), 600,
            marginAll: 5 * (72.0 / 25.4)),
        //pageFormat: format,
        build: (context) {
          return pdfWid.SizedBox(
            width: double.infinity,
            child: pdfWid.FittedBox(
                child: pdfWid.Column(
                    mainAxisAlignment: pdfWid.MainAxisAlignment.start,
                    children: [
                  pdfWid.Text(widget.currentItem['name'],
                      style: pdfWid.TextStyle(
                          fontSize: 35, fontWeight: pdfWid.FontWeight.bold)),
                  pdfWid.Container(
                    width: 250,
                    height: 1.5,
                    margin: pdfWid.EdgeInsets.symmetric(vertical: 5),
                    color: PdfColors.black,
                  ),
                  pdfWid.Container(
                    width: 300,
                    child: pdfWid.Text(
                        'Leito ${widget.currentItem['leito'].toString()}',
                        style: pdfWid.TextStyle(
                          fontSize: 35,
                          fontWeight: pdfWid.FontWeight.bold,
                        ),
                        textAlign: pdfWid.TextAlign.center,
                        maxLines: 5),
                  ),
                  pdfWid.Container(
                    width: 250,
                    height: 1.5,
                    margin: pdfWid.EdgeInsets.symmetric(vertical: 10),
                    color: PdfColors.black,
                  ),
                  pdfWid.Text("Evolução",
                      style: pdfWid.TextStyle(
                          fontSize: 25, fontWeight: pdfWid.FontWeight.bold)),
                  pdfWid.Wrap(
                    children: [
                      pdfWid.Text(
                          'Parâmetros: ${widget.currentItem['parametros'].toString()}',
                          style: pdfWid.TextStyle(
                              fontSize: 10,
                              fontWeight: pdfWid.FontWeight.bold)),
                    ],
                  ),
                ])),
          );
        },
      ),
    );
    return pdf.save();
  }
}
