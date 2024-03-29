import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Model/expense/get_expense_food_model.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/food_claimed/make_pdf_food.dart';


import 'package:salebee/utils.dart';

class PdfPreviewPage extends StatelessWidget {
  final GetFoodExpenseModel? invoice;
  List expenselist;
  int monthSelection;
  int yearSelection ;
  PdfPreviewPage({Key? key, required this.invoice, required this.monthSelection, required this.yearSelection, required this.expenselist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColorLight,
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdfFood(invoice!, monthSelection, yearSelection, expenselist),
      ),
    );
  }

}