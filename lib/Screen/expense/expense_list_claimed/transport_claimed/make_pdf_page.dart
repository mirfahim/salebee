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

Future<Uint8List> makePdf(GetTransportExpenseModel invoice) async {
  final pdf = pw.Document();

  // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
  pdf.addPage(
    Page(

      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.start,
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
                pw.Spacer(),
                Expanded(
                  child: PaddedText(
                      "${DateFormat.yMMM().format(DateTime.now())}"),
                  flex: 2,
                ),

                // SizedBox(
                //   height: 150,
                //   width: 150,
                //   child: Image(imageLogo),
                // )
              ],
            ),
            Container(

                height: 50,
              child: Center(
                child: Text("Expense Sheet (Transport)",
                style: pw.TextStyle(
                  fontSize: 16,
                 fontWeight: pw.FontWeight.bold
                ))
              )
            ),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                // TableRow(
                //   children: [
                //     PaddedText('Department'),
                //     PaddedText(
                //       StaticData.employeeID.toString(),
                //     )
                //   ],
                // ),
                // TableRow(
                //   children: [
                //     PaddedText('Employee ID'),
                //     PaddedText(
                //       StaticData.employeeID.toString(),
                //     )
                //   ],
                // ),
                TableRow(
                  children: [
                    PaddedText(
                      'Account Name',
                    ),
                    PaddedText(
                      StaticData.name!,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Designation',
                    ),
                    PaddedText(
                        StaticData.designation)
                  ],
                )
              ],
            ),
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
                        'Type',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Location',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Cost',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'Status',
                        style: Theme.of(context).header5,
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
                            "${ DateFormat('EEEE').format(e.createdOn!).toString().substring(0,3) + ","} ${e.createdOn
                                .toString()
                                .substring(8, 10)}"),
                        flex: 1,
                      ),
                      e.vehicleType == 0
                          ? Expanded(
                              child: PaddedText("Bus"),
                              flex: 1,
                            )
                          : e.vehicleType == 1 ?
                      Expanded(
                        child: PaddedText("Bus"),
                        flex: 1,
                      ) :
                      e.vehicleType == 2 ?
                      Expanded(
                        child: PaddedText("Bus"),
                        flex: 1,
                      ) :e.vehicleType == 3 ?
                      Expanded(
                        child: PaddedText("Bus"),
                        flex: 1,
                      ) :
                      e.vehicleType == 4 ?
                      Expanded(
                        child: PaddedText("Bus"),
                        flex: 1,
                      ): Expanded(
                              child: PaddedText("Bus"),
                              flex: 1,
                            ),
                      Expanded(
                        child: PaddedText("${e.startLocation!.toString()} - ${e.endLocation!.toString()}"),
                        flex: 2,
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
                  ),
                ),
                TableRow(
                  children: [
                    PaddedText('TOTAL', align: TextAlign.right),
                    PaddedText(''),
                    PaddedText(''),
                    PaddedText(
                        '\$${(invoice.totalCost() * 1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Padding(
              child: Text(
                "THANK YOU FOR YOUR CUSTOM!",
                style: Theme.of(context).header2,
              ),
              padding: EdgeInsets.all(20),
            ),
            Text(
                "Please forward the below slip to your accounts payable department."),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'SaleBee CRM',
                style: Theme.of(context).header3.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            )
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
