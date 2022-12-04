import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/expense/get_expense_food_model.dart';


import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdf(GetFoodExpenseModel invoice) async {
  final pdf = pw.Document();

  // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Column(
              children: [
                Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      PaddedText("${DateFormat.yMd().format(DateTime.now())}"),
                    ]),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nexzen Solution Ltd",
                        style: TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "House: 545, 2nd floor, Suite A2, Road 8, Mirpur DOHS",
                        style: TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            pw.SizedBox(height: 10),
            Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                    ),
                    shape: BoxShape.rectangle),
                child: Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      Text("Expense Sheet",
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                      Text("(Food)",
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ])),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  Spacer(),
                  PaddedText("${DateFormat.yMMM().format(DateTime.now())}"),
                ]),
            Row(children: [
              Container(
                  child: Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        Text(
                          StaticData.name!,
                        ),
                        Text(StaticData.designation),
                      ])),
              Spacer(),
            ]),
            pw.SizedBox(height: 20),
            Container(height: 20),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'Date',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Meal Type ',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Purpose/Description',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Amount',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Status',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),

                  ],
                ),

                ...invoice.result!.map(
                      (e) => TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(
                            "${DateFormat('EEEE').format(e.createdOn!).toString().substring(0, 3) + ","} ${e.createdOn.toString().substring(8, 10)}"),
                        flex: 1,
                      ),


                      Expanded(
                        child: PaddedText(
                            "Breakfast"),
                        flex: 1,
                      ),
                      Expanded(
                        child: PaddedText(
                            "Descriptionof food expense"),
                        flex: 1,
                      ),
                      Expanded(
                        child: PaddedText("${e.expense!.toString()}"),
                        flex: 1,
                      ),
                      Expanded(
                        child: PaddedText(
                            "Approved"),
                        flex: 1,
                      ),
                    ],
                  ),
                ),

                TableRow(
                  children: [
                    PaddedText('TOTAL', align: TextAlign.right),
                    PaddedText(
                        ''),
                    PaddedText(
                        ''),
                    PaddedText(
                        '\$${(invoice.totalCost() * 1).toStringAsFixed(2)}')
                  ],
                ),

              ],
            ),

            pw.SizedBox(height: 40)
,
            Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Divider(
                      height: 1,
                      borderStyle: BorderStyle.dashed,
                    ),
                    Text("Received Signature & Date"),

                  ]),
                  Column(children: [
                    Divider(
                      height: 1,
                      borderStyle: BorderStyle.dashed,
                    ),
                    Text("Accounts Checked"),

                  ]),
                  Column(children: [
                    Divider(
                      height: 1,
                      borderStyle: BorderStyle.dashed,
                    ),
                    Text("Approved by"),

                  ]),
                ])

          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
    final String text, {
      final TextAlign align = TextAlign.left,
    }) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
