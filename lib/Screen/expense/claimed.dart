import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/expense/expense_create/expense_create_front.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/food_claimed/food_expense_list.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/other_claimed/others_expense_list.dart';
import 'package:salebee/Utils/my_colors.dart';
import 'package:salebee/repository/expense_repository.dart';
import 'package:salebee/utils.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

import '../../Model/expense/get_all_expense_model.dart';
import 'all_expense_pdf_preview.dart';
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

class Claimed extends StatefulWidget {
  const Claimed({Key? key}) : super(key: key);

  @override
  State<Claimed> createState() => _ClaimedState();
}

class _ClaimedState extends State<Claimed> {
  ExpenseRepository expenseRepository = ExpenseRepository();
  List transportCostList = [];
  List foodCostList = [];
  List othersCostList = [];

  List<String> yearList = <String>[DateTime.now().year.toString(), DateTime(DateTime.now().year-1).toString().substring(0,4), DateTime(DateTime.now().year-2).toString().substring(0,4) ];

  int yearSelection = int.parse(DateTime.now().toString().substring(0,4));
  String dropdownValue = DateTime.now().year.toString();
  double foodCost = 0.0;
  double transposrCost = 0.0;
  double otherCost = 0.0;
  int selectMonth = int.parse(DateTime.now().toString().substring(5,7));
  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      width: 70,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        icon: Icon(Icons
                            .arrow_drop_down_outlined),
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors
                                .deepPurple),
                        underline:
                        Container(
                          height: 2,
                          color: Colors
                              .transparent,
                        ),

                        onChanged: (String? value) {

                          // This is called when the user selects an item.
                          setState(() {
                            foodCost = 0.0;
                            transposrCost = 0.0;
                            otherCost = 0.0;
                            transportCostList.clear();
                            foodCostList.clear();
                            othersCostList.clear();
                            print("++++++++ ${othersCostList.length}");

                            dropdownValue = value!;
                            yearSelection = int.parse(dropdownValue);
                          });
                        },
                        items: yearList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  DefaultTabController(
                    initialIndex: selectMonth -1,
                    length: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 150,
                      child: TabBar(
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primaryColorSecond.withOpacity(.5)),
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,


                        onTap: (index){
                          setState((){
                            selectMonth = index+1;
                          });

                        },
                        tabs: tabs
                            .map((tab) => Tab(
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(tab),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),

              FutureBuilder<GetAllExpenseModel>(
                future: expenseRepository.getAllExpense(),
                builder: (BuildContext context,
                    AsyncSnapshot<GetAllExpenseModel> snapshot) {

                  if (snapshot.data == null) {
                    print("no data found");
                  } else {

                    snapshot.data!.result!.forEach((e) {
                      transportCostList.clear();
                      foodCostList.clear();
                      othersCostList.clear();
                      print("llllllll ${e.date.toString().substring(5,7)} +++ ${e.date.toString().substring(0,4)}");
                      if(selectMonth == int.parse(e.date.toString().substring(5,7)) && yearSelection == int.parse(e.date.toString().substring(0,4)) && e.type == "Transport"){
                        transportCostList.add(e.cost);
                        transportCostList.forEach((e){
                          transposrCost += e;

                        });
                      } else if(selectMonth == int.parse(e.date.toString().substring(5,7)) && yearSelection == int.parse(e.date.toString().substring(0,4)) && e.type == "Food"){

                          foodCostList.add(e.cost);
                          foodCostList.forEach((e){
                            foodCost += e;
                        });
                      } else if(selectMonth == int.parse(e.date.toString().substring(5,7)) && yearSelection == int.parse(e.date.toString().substring(0,4)) && e.type == "Other") {
                        othersCostList.add(e.cost);
                        othersCostList.forEach((e){
                          otherCost += e;
                        });
                      }

                    });
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text("waiting");
                    default:
                      if (snapshot.hasError)
                        return Center(child: Text('No Data Found'));
                      if (snapshot.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container(
                          height: 500,
                          child: Column(
                            children: [
                              Text(
                                'Choose a type of expense',
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(.75)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
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
                                        border:
                                            Border.all(color: primaryColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'images/transportation.png',
                                            height: 40,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            ' Transport',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Spacer(),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Claimed",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      transposrCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Approved",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      transposrCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Pending",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      transposrCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
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
                                onTap: () {
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
                                        border:
                                            Border.all(color: primaryColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'images/food.png',
                                            height: 70,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            ' Food',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          Spacer(),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Claimed",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      foodCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Approved",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      foodCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Pending",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      foodCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
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
                                onTap: () {
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
                                        border:
                                            Border.all(color: primaryColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'images/more.png',
                                            height: 70,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            ' Others',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          Spacer(),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Claimed",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      otherCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Approved",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      otherCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Pending",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ),
                                                    Text(
                                                      otherCost.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    )
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
                              //Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (builder) => AllExPdfPreviewPage(invoice: snapshot.data!, monthSelection: selectMonth, yearSelection: 2023, ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                          'images/Icons/utility_expense.png',
                                        ))),
                                      ),
                                      Text(
                                        "View PDF",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      }
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Get.to(ExpenseCreateFront(
                        page: "transport",
                      ));
                    },
                    child: Container(
                      height: 48,
                      //width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: darkBlue),
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
