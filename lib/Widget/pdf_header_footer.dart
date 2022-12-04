// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:salebee/Data/static_data.dart';
// import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
// import 'package:salebee/Service/sharedPref_service.dart';
// import 'package:salebee/utils.dart';
//
// import 'package:universal_html/html.dart' as html;
// import 'dart:typed_data';
//
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'dart:io';
// import 'package:flutter/services.dart' show rootBundle;
//
//
//   // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
//
//     Column(
//           mainAxisAlignment: pw.MainAxisAlignment.center,
//           crossAxisAlignment: pw.CrossAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 Row(
//                     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                     children: [
//                       Spacer(),
//                       PaddedText("${DateFormat.yMd().format(DateTime.now())}"),
//                     ]),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Nexzen Solution Ltd",
//                         style: TextStyle(
//                             fontWeight: pw.FontWeight.bold, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "House: 545, 2nd floor, Suite A2, Road 8, Mirpur DOHS",
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: pw.FontWeight.normal),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//               crossAxisAlignment: CrossAxisAlignment.start,
//             ),
//             pw.SizedBox(height: 10),
//             Container(
//                 height: 60,
//                 width: 150,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 1.0,
//                     ),
//                     shape: BoxShape.rectangle),
//                 child: Column(
//                     mainAxisAlignment: pw.MainAxisAlignment.center,
//                     crossAxisAlignment: pw.CrossAxisAlignment.center,
//                     children: [
//                       Text("Expense Sheet",
//                           style: pw.TextStyle(
//                               fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                       Text("(Transport)",
//                           style: pw.TextStyle(
//                               fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     ])),
//             SizedBox(height: 10),
//             Row(
//                 crossAxisAlignment: pw.CrossAxisAlignment.end,
//                 mainAxisAlignment: pw.MainAxisAlignment.end,
//                 children: [
//                   Spacer(),
//                   PaddedText("${DateFormat.yMMM().format(DateTime.now())}"),
//                 ]),
//             Row(children: [
//               Container(
//                   child: Column(
//                       mainAxisAlignment: pw.MainAxisAlignment.start,
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           StaticData.name!,
//                         ),
//                         Text(StaticData.designation),
//                       ])),
//               Spacer(),
//             ]),
//             pw.SizedBox(height: 20),
//
//             SizedBox(height: 40),
//             Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(children: [
//                     Container(height: 3, width: 60),
//                     Text("Received Signature & Date"),
//                     pw.SizedBox(width: 10),
//                   ]),
//                   Column(children: [
//                     Container(
//                       height: 5,
//                       width: 60,
//                     ),
//                     Text("Accounts Checked"),
//                     pw.SizedBox(width: 10),
//                   ]),
//                   Column(children: [
//                     Container(height: 5, width: 60),
//                     Text("Approved by"),
//                     pw.SizedBox(width: 10),
//                   ]),
//                 ])
//           ],
//         ),
//
//
//
//
//
//
