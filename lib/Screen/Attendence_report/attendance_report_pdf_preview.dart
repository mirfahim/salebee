import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:salebee/Model/get_attendance_model.dart';
import 'package:salebee/Screen/Attendence_report/individual_report/make_pdf.dart';



import 'package:salebee/utils.dart';

class PdfPreviewPage extends StatelessWidget {
  final GetAttendanceDataModel? report;
  int? monthSelection;
  String name;
  int? yearSelection;
   PdfPreviewPage({Key? key, required this.report, required this.yearSelection, required this.monthSelection,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColorLight,
        title: Text('PDF Previeww'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(report!, yearSelection!, monthSelection, name),
      ),
    );
  }

}