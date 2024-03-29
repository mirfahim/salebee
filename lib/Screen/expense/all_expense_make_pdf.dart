import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Model/expense/get_all_expense_model.dart';
import 'package:salebee/Service/sharedPref_service.dart';
import 'package:salebee/utils.dart';

import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdf(GetAllExpenseModel invoice, monthSelection, yearSelection) async {
  final pdf = pw.Document();

  List<pw.Widget> widgets = [];
  double totalAmount= 0;
  widgets.add(pw.SizedBox(height: 5));

  widgets.add(
    Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Text("Printed on: ${DateFormat.yMd().format(DateTime.now())}," + " ${DateFormat.jm().format(DateTime.now())}",
                    style: TextStyle(
                        fontWeight: pw.FontWeight.normal, fontSize: 12),),
                ]),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nexzen Solution Ltd",
                    style: TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 12),
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
                        fontSize: 12, fontWeight: pw.FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        pw.SizedBox(height: 10),
        Container(
            height: 40,
            width: 140,
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
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  Text("All",
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                ])),
        SizedBox(height: 10),
        Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              Spacer(),
              PaddedText("${DateFormat.yMMM().format(DateTime(yearSelection,monthSelection))}"),
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



      ],
    ),
  );
  widgets.add(
    Table(
      border: TableBorder.all(color: PdfColors.black),
      children: [
        TableRow(
          children: [
            Text(
              'Date',

              textAlign: TextAlign.center,
            ),
            Text(
              'Type',

              textAlign: TextAlign.center,
            ),
            Text(
              'Purposes/ Description',

              textAlign: TextAlign.center,
            ),
            Text(
              'Person',

              textAlign: TextAlign.center,
            ),
            Text(
              'Cost',

              textAlign: TextAlign.center,
            ),
            Text(
              'Status',

              textAlign: TextAlign.center,
            ),
          ],
        ),
        ...invoice.result!.map(
              (e) {

            if(monthSelection == int.parse(e.date.toString().substring(5,7)) && yearSelection == int.parse(e.date.toString().substring(0,4))){
              invoice.result!.forEach((element) {
                if(monthSelection == int.parse(element.date.toString().substring(5,7)) && yearSelection == int.parse(element.date.toString().substring(0,4))){
                  totalAmount += element.cost!;
                }

              });
              return TableRow(
                children: [
                  Expanded(
                    child: PaddedText(
                        "${DateFormat('EEEE').format(e.date!).toString().substring(0, 3) + ","} ${e.date.toString().substring(8, 10)}"),
                    flex: 1,
                  ),

                  Expanded(
                    child: PaddedText(
                        "${e.type}"),
                    flex: 2,
                  ),
                  Expanded(
                    child: PaddedText(
                         "${e.description}"),
                    flex: 2,
                  ),
                  Expanded(
                    child: PaddedText("${e.person!.toString()}"),
                    flex: 1,
                  ),
                  Expanded(
                    child: PaddedText("${e.cost!.toString()}"),
                    flex: 1,
                  ),
                  e.status == 0 ?
                  Expanded(
                    child: PaddedText("Claimed"),
                    flex: 1,
                  ) : Expanded(
                    child: PaddedText("Approved"),
                    flex: 1,
                  ),
                ],
              );
            } else {
              return TableRow(

                children: [

                ],
              );
            }

          },
        ),
        TableRow(
          children: [
            PaddedText('TOTAL', align: TextAlign.right),
            PaddedText(''),
            PaddedText(''),
            PaddedText(
                '\$${totalAmount.toString()}')
          ],
        )
      ],
    ),
  );
  widgets.add(
    pw.Spacer(),
  );
  widgets.add(
      Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Container(
                width: 100,
                child:  Divider(

                    thickness: 1
                ),
              ),
              Text("Received Signature & Date"),
              pw.SizedBox(width: 10),
            ]),
            Column(children: [
              Container(
                width: 100,
                child:  Divider(

                    thickness: 1
                ),
              ),
              Text("Accounts Checked"),
              pw.SizedBox(width: 10),
            ]),
            Column(children: [
              Container(
                width: 100,
                child:  Divider(

                    thickness: 1
                ),
              ),
              Text("Approved by"),
              pw.SizedBox(width: 10),
            ]),
          ])
  );
  // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
  pdf.addPage(
    MultiPage(
        build: (context) => widgets


    ),
  );
  return pdf.save();
}

Widget PaddedText(
    final String text, {
      final TextAlign align = TextAlign.left,
    }) =>
    Padding(
      padding: EdgeInsets.all(2),
      child: Text(
        text,
        textAlign: align,
      ),
    );
