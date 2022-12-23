import "package:flutter/material.dart";
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewFile extends StatelessWidget {
  ViewFile({Key? key, this.fileName}) : super(key: key);
  var fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 57, 104, 1),
        title: Container(
            padding: EdgeInsets.only(right: 50),
            alignment: Alignment.center,
            child: Text("View Dokumen")),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: SfPdfViewer.network(
          "https://project.mis.pens.ac.id/mis142/contents/uploads/${fileName}"),
    );
  }
}
