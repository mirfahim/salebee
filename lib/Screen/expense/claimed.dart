import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/expense/expense_create/expense_create_front.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/food_claimed/food_expense_list.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/other_claimed/others_expense_list.dart';
import 'package:salebee/Utils/my_colors.dart';
import 'package:salebee/utils.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;


import 'expense_list_claimed/transport_claimed/transport_expense_list.dart';
List<String> tabs = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
class Claimed extends StatelessWidget {
  const Claimed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLight,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 11,
                  child: Column(
                    children: [
                      TabBar(
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primaryColor),
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                        tabs: tabs
                            .map((tab) => Tab(
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(tab),
                          ),
                        ))
                            .toList(),
                      ),

                    ],
                  ),
                ),
              ),
              Text('Chose a type of expense',style: TextStyle(
                  color: Colors.grey.withOpacity(.75)
              ),),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Get.to(TransportClaimedList());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: primaryColor)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset('images/transportation.png',height: 40,),
                          const SizedBox(width: 10,),
                          const Text(' Transport',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                          Spacer(),
                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Claimed",style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),)
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Approved",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black54
                                        ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color:Colors.black54
                                      ),)
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Pending",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black54
                                        ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),)
                                  ],
                                ),


                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(FoodClaimedList());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: primaryColor)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset('images/food.png',height: 70,),
                          const SizedBox(width: 10,),
                          const Text(' Food',style: TextStyle(
                              fontWeight: FontWeight.w500,
                            fontSize: 18
                          ),),
                          Spacer(),
                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Claimed",style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),)
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Approved",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black54
                                        ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color:Colors.black54
                                      ),)
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Pending",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black54
                                        ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),)
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  Get.to(OtherClaimedList());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: primaryColor)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset('images/more.png',height: 70,),
                          const SizedBox(width: 10,),
                          const Text(' Others',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),),
                          Spacer(),
                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Claimed",style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),)
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Approved",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black54
                                        ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color:Colors.black54
                                      ),)
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Container(
                                      child: Text("Pending",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color: Colors.black54
                                        ),),
                                    ),
                                    Text("243",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54
                                      ),)
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Spacer(),
              GestureDetector(
                  onTap: (){
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (builder) => PdfPreviewPage(invoice: snapshot.data! ),
                    //   ),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(  'images/Icons/utility_expense.png',)
                            )
                        ),
                      ),
                      Text("View PDF", style: TextStyle(
                          color: Colors.black54
                      ),),
                    ],
                  )
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Get.to(ExpenseCreateFront());
                    },
                    child: Container(
                      height: 48,
                      //width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6), color: darkBlue),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Add New Expense',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> pdfDownload() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}
