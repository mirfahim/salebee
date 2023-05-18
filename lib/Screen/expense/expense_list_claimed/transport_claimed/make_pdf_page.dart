import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Service/sharedPref_service.dart';
import 'package:salebee/utils.dart';

import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makeTransPdf(GetTransportExpenseModel invoice, monthSelection, yearSelection) async {
  final pdf = pw.Document();
  List<String> way = ['Rikshaw', 'Bus', 'Bike', 'Car','CNG,', 'Train', 'Air', 'Others'];
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
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  Text("(Transport)",
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
            Padding(
              child: Text(
                'Date',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(5),
            ),
            Padding(
              child: Text(
                'Type',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(5),
            ),
            Padding(
              child: Text(
                'Purposes/ Description',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(5),
            ),
            Padding(
              child: Text(
                'Person',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(5),
            ),
            Padding(
              child: Text(
                'Cost',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(5),
            ),
            Padding(
              child: Text(
                'Status',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(5),
            ),
          ],
        ),
        ...invoice.result!.map(
              (e) {

                if(monthSelection == int.parse(e.createdOn.toString().substring(5,7)) && yearSelection == int.parse(e.createdOn.toString().substring(0,4))){
                 invoice.result!.forEach((element) {
                   if(monthSelection == int.parse(element.createdOn.toString().substring(5,7)) && yearSelection == int.parse(element.createdOn.toString().substring(0,4))){
                     totalAmount += element.expense!;
                   }

                 });
                  return TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(
                            "${DateFormat('EEEE').format(e.createdOn!).toString().substring(0, 3) + ","} ${e.createdOn.toString().substring(8, 10)}"),
                        flex: 1,
                      ),
                      e.vehicleType == 0
                          ? Expanded(
                        child: PaddedText(way[0]),
                        flex: 1,
                      )
                          : e.vehicleType == 1
                          ? Expanded(
                        child: PaddedText(way[1]),
                        flex: 1,
                      )
                          : e.vehicleType == 2
                          ? Expanded(
                        child: PaddedText(way[2]),
                        flex: 1,
                      )
                          : e.vehicleType == 3
                          ? Expanded(
                        child: PaddedText(way[3]),
                        flex: 1,
                      )
                          : e.vehicleType == 4
                          ? Expanded(
                        child: PaddedText(way[4]),
                        flex: 1,
                      )
                          : Expanded(
                        child: PaddedText(way[5]),
                        flex: 1,
                      ),
                      Expanded(
                        child: PaddedText(
                            "${e.startLocation!.toString()} - ${e.endLocation!.toString()}" + " ${e.description}"),
                        flex: 2,
                      ),
                      Expanded(
                        child: PaddedText("${e.person!.toString()}"),
                        flex: 1,
                      ),
                      Expanded(
                        child: PaddedText("${e.expense!.toString()}"),
                        flex: 1,
                      ),
                      Expanded(
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
  widgets.add(
    pw.SizedBox(height: 20),
  );

  widgets.add(
    Row(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          Spacer(),
          Text("Printed on: ${DateFormat.yMd().format(DateTime.now())}," + " ${DateFormat.jm().format(DateTime.now())}",
            style: TextStyle(
                fontWeight: pw.FontWeight.normal, fontSize: 12),),
        ]),
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
