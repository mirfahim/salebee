import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/transport_claimed/make_pdf_page.dart';


import 'package:salebee/utils.dart';

class PdfPreviewPage extends StatelessWidget {
  final GetTransportExpenseModel? invoice;
  int monthSelection;
  int yearSelection ;
   PdfPreviewPage({Key? key, required this.invoice, required this.monthSelection, required this.yearSelection, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColorLight,
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice!, monthSelection, yearSelection),
      ),
    );
  }

}