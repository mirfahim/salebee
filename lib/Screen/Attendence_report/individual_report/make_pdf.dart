import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Model/expense/get_expense_food_model.dart';
import 'package:salebee/Service/sharedPref_service.dart';
import 'package:salebee/utils.dart';

import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import '../../../Model/get_attendance_model.dart';

Future<Uint8List> makePdf(GetAttendanceDataModel report, yearSelection, monthSelection) async {
  final pdf = pw.Document();
  List<pw.Widget> widgets = [];
  widgets.add(pw.SizedBox(height: 5));
  var font = await PdfGoogleFonts.bangersRegular();
  final fontData = await rootBundle.load('assets/font/Kalpurush.ttf');
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());

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
                  Text("Printed onn: ${DateFormat.yMd().format(DateTime.now())}," + " ${DateFormat.jm().format(DateTime.now())}",
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
                  Text("Attendance Sheet",
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  Text("",
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
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

        SizedBox(height: 40),

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
              padding: EdgeInsets.all(20),
            ),
            Padding(
              child: Text(
                'Check In',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(20),
            ),
            Padding(
              child: Text(
                'Check Out',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(20),
            ),
            // Padding(
            //   child: Text(
            //     'In Time',
            //
            //     textAlign: TextAlign.center,
            //   ),
            //   padding: EdgeInsets.all(20),
            // ),

            Padding(
              child: Text(
                'Working Hour',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(20),
            ),
            Padding(
              child: Text(
                'Note',

                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
        ...report.result!.map(
              (e) {
                final hours = DateTime.parse(
                    e.logTimeOut ??
                        "2035-09-13T21:06:40.32")
                    .difference(
                    DateTime.parse(e.logTimeIn))
                    .inHours;
                final minutes = DateTime.parse(
                    e.logTimeOut ??
                        "2035-09-13T21:06:40.32")
                    .difference(
                    DateTime.parse(e.logTimeIn))
                    .inMinutes;
                final totalWorkingHours =
                    '$hours.${(minutes - (hours * 60))}';

                if ( monthSelection ==
                    int.parse(e.logTimeIn
                        .toString()
                        .substring(5, 7)) && yearSelection == int.parse(e.logTimeIn
                    .toString()
                    .substring(0, 4)) ){
                  return TableRow(

                    children: [
                      Expanded(
                        child: PaddedText(

                            "${DateFormat('EEEE').format(e.createdOn!).toString().substring(0, 3) + ","} ${e.createdOn.toString().substring(8, 10)}"),
                        flex: 1,
                      ),
                      Expanded(
                        child: Column(
                            children: [
                              PaddedText("${DateFormat.jm().format(DateTime.parse(e.logTimeIn))}"),
                              Text(

                                  e.locationDescription.toString(),

                                  style: pw.TextStyle(
                                    font: ttf,
                                  )
                                  ),
                            ]
                        ),

                        flex: 1,
                      ),

                      Expanded(
                        child: e.logTimeOut != null ?  Column(
                            children: [
                              PaddedText("${DateFormat.jm().format(DateTime.parse(e.logTimeOut))}"),
                              Text(

                                  e.locationDescriptionOut.toString(),
                              style: pw.TextStyle(
                                font: ttf,
                              )),
                            ]
                        )
                            :Column(
                            children: [
                              PaddedText("${DateFormat.jm().format(DateTime.parse(e.logTimeIn))}"),
                              Text(

                                  e.locationDescription.toString(),
                                  style: pw.TextStyle(
                                    font: ttf,
                                  )),
                            ]
                        ),
                        flex: 1,
                      ),
                      // Expanded(
                      //   child: int.parse(e.logTimeIn.substring(11,12)) < 10 ?
                      //   PaddedText(int.parse(e.logTimeIn.substring(11,13)).toString()) : PaddedText("No"),
                      //   flex: 1,
                      // ),
                      Expanded(
                        child:double.parse(
                            totalWorkingHours) >
                            18.00 ?PaddedText(

                            "No Data"):
                        PaddedText(

                            "${totalWorkingHours}" + " hrs"),
                        flex: 1,
                      ),
                      Expanded(
                        child: PaddedText(e.checkOutNote ?? "No data"),
                        flex: 2,
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
                ""),
            // '\$${(invoice.totalCost() * 1).toStringAsFixed(2)}')
          ],
        )
      ],
    ),
  );
  widgets.add(
    pw.SizedBox(height: 60),
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
              Text("Admin Checked"),
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

    pw.MultiPage(

        build: (context) {
          return
            widgets
          ;
        }
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
        style: pw.TextStyle(

        )
      ),
    );
