import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Screen/expense/expense_create/expense_create_front.dart';
import 'package:salebee/Screen/expense/expense_create/other_expense.dart';

import 'package:salebee/Screen/expense/expense_list_claimed/transport_claimed/expense_pdf_preview.dart';
import 'package:salebee/repository/expense_repository.dart';
import 'package:salebee/utils.dart';

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
List list = [];

class TransportClaimedList extends StatefulWidget {
  const TransportClaimedList({Key? key}) : super(key: key);

  @override
  State<TransportClaimedList> createState() => _ApprovedState();
}

class _ApprovedState extends State<TransportClaimedList> {
  ExpenseRepository expenseRepository = ExpenseRepository();
  String vehicleName = "";
  double totalBalance = 0.0;
  int selectMonth = int.parse(DateTime.now().toString().substring(5, 7));
  List<String> way = [
    'Rikshaw',
    'Bus',
    'Bike',
    'Car',
    'CNG,',
    'Train',
    'Air',
    'Others'
  ];
  List<String> yearList = <String>[
    DateTime.now().year.toString(),
    DateTime(DateTime.now().year - 1).toString().substring(0, 4),
    DateTime(DateTime.now().year - 2).toString().substring(0, 4)
  ];
  String dropdownValue = DateTime.now().year.toString();
  int yearSelection = int.parse(DateTime.now().toString().substring(0, 4));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primaryColorLight,
        appBar: AppBar(
          backgroundColor: primaryColorLight,
          title: Text(
            "Transport Expense Claimed",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60, right: 10, left: 10),
              child: Column(
                children: [
                  Expanded(
                    child: DefaultTabController(
                      initialIndex: selectMonth - 1,
                      length: 12,
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
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                        yearSelection =
                                            int.parse(dropdownValue);
                                      });
                                    },
                                    items: yearList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: TabBar(
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          primaryColorSecond.withOpacity(.5)),
                                  isScrollable: true,
                                  indicatorColor: Colors.black,
                                  labelColor: Colors.black,
                                  onTap: (index) {
                                    setState(() {
                                      selectMonth = index + 1;
                                    });
                                  },
                                  tabs: tabs
                                      .map((tab) => Tab(
                                            icon: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(tab),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder<GetTransportExpenseModel>(
                            future: expenseRepository
                                .getTransportExpense(), // async work
                            builder: (BuildContext context,
                                AsyncSnapshot<GetTransportExpenseModel>
                                    snapshot) {
                              list.clear();
                              totalBalance = 0;

                              if (snapshot.data == null) {
                                print("snapshot no data found");
                              } else {
                                snapshot.data!.result!.forEach((element) {
                                  if (selectMonth ==
                                          int.parse(element.createdOn
                                              .toString()
                                              .substring(5, 7)) &&
                                      yearSelection ==
                                          int.parse(element.createdOn
                                              .toString()
                                              .substring(0, 4))) {
                                    list.add(element.expense);
                                    totalBalance = list.fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element);

                                    print(
                                        "total amount is  $totalBalance and ${list[0]}");
                                  }
                                });
                              }

                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                      child:
                                          LoadingAnimationWidget.twistingDots(
                                    leftDotColor: const Color(0xFF8686E3),
                                    rightDotColor: const Color(0xFFEA3799),
                                    size: 100,
                                  ));
                                default:
                                  if (snapshot.hasError)
                                    return Center(child: Text('No Data Found'));
                                  if (snapshot.data == null) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Total Expense: ',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                totalBalance.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                ' BDT',
                                                style: TextStyle(
                                                    color: Colors.grey
                                                        .withOpacity(.5),
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              300,
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data!.result!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                var data = snapshot
                                                    .data!.result![index];
                                                if (data.vehicleType == 0) {
                                                  vehicleName = way[0];
                                                }
                                                if (data.vehicleType == 1) {
                                                  vehicleName = way[1];
                                                }
                                                if (data.vehicleType == 2) {
                                                  vehicleName = way[2];
                                                }
                                                if (data.vehicleType == 3) {
                                                  vehicleName = way[3];
                                                }
                                                if (data.vehicleType == 4) {
                                                  vehicleName = way[4];
                                                }
                                                if (data.vehicleType == 5) {
                                                  vehicleName = way[5];
                                                }
                                                if (data.vehicleType == 6) {
                                                  vehicleName = way[6];
                                                }

                                                if (selectMonth ==
                                                        int.parse(data.createdOn
                                                            .toString()
                                                            .substring(5, 7)) &&
                                                    yearSelection ==
                                                        int.parse(data.createdOn
                                                            .toString()
                                                            .substring(0, 4))) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    .5)),
                                                        color: blue
                                                            .withOpacity(.1)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: IntrinsicHeight(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                height: 42,
                                                                decoration: BoxDecoration(
                                                                    color: primaryColorSecond
                                                                        .withOpacity(
                                                                            .3),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6)),
                                                                width: 70,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            DateFormat('EEEE').format(data.startTime!).toString().substring(0, 3) +
                                                                                ",",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                          Center(
                                                                            child:
                                                                                Text(
                                                                              " " + data.startTime.toString().substring(8, 10),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            DateFormat('MMM').format(data.startTime!),
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Card(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              DateFormat.jm().format(data.startTime!),
                                                                              style: TextStyle(fontSize: 8),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                            const VerticalDivider(
                                                              thickness: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              flex: 5,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    vehicleName,
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  Text(": "),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Text(
                                                                                    data.expense.toString(),
                                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                  Text(
                                                                                    ' BDT',
                                                                                    style: TextStyle(color: Colors.grey.withOpacity(.7)),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width - 200,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Start: ',
                                                                                    style: TextStyle(color: Colors.black.withOpacity(.7)),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      data.startLocation!,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(color: Colors.black.withOpacity(.4)),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width - 200,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'End: ',
                                                                                    style: TextStyle(color: Colors.black.withOpacity(.7)),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      data.endLocation!,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(color: Colors.black.withOpacity(.4)),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),

                                                                      // Container(
                                                                      //   width: MediaQuery.of(context).size.width -200,
                                                                      //   child: Row(
                                                                      //     mainAxisAlignment:  MainAxisAlignment.start,
                                                                      //     children: [
                                                                      //       Text('Prospect: ',style: TextStyle(
                                                                      //           color: Colors.black.withOpacity(.7)
                                                                      //       ),),
                                                                      //       Text('tset prospect name',style: TextStyle(
                                                                      //           color: Colors.grey.withOpacity(.7)
                                                                      //       ),),
                                                                      //     ],
                                                                      //   ),
                                                                      // ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width -
                                                                            200,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              'Description: ',
                                                                              style: TextStyle(color: Colors.black.withOpacity(.7)),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                data.description!,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: Colors.grey.withOpacity(.7)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              }),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (builder) =>
                                                      PdfPreviewPageTrans(
                                                    invoice: snapshot.data!,
                                                    monthSelection: selectMonth,
                                                    yearSelection:
                                                        yearSelection,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                    width: size.width,
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
        ));
  }
}
