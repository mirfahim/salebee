import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Screen/expense/all_expense_pdf_preview.dart';
import 'package:salebee/Screen/expense/expense_create/expense_create_front.dart';
import 'package:salebee/Screen/expense/expense_create/other_expense.dart';

import 'package:salebee/Screen/expense/expense_list_claimed/transport_claimed/expense_pdf_preview.dart';
import 'package:salebee/Utils/my_colors.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:salebee/repository/expense_repository.dart';
import 'package:salebee/utils.dart';

import '../../../Model/employee/employee_list_model.dart';
import '../../../Model/expense/get_all_expense_model.dart';

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
List<String> approveTabs = [
  "All",
  "Approved",
  "Claimed",
];
AttendanceRepository attendanceRepository = AttendanceRepository();

class AdminApprovalToList extends StatefulWidget {
  const AdminApprovalToList({Key? key}) : super(key: key);

  @override
  State<AdminApprovalToList> createState() => _ApprovedState();
}

class _ApprovedState extends State<AdminApprovalToList> {
  ExpenseRepository expenseRepository = ExpenseRepository();
  String vehicleName = "";
  int? employeeID;
  bool load = false;
  bool? check3 = false;
  String? newEmployee;
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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60, right: 10, left: 10),
              child: Column(
                children: [
                  FutureBuilder<AllEmployeeListModel>(
                    future: attendanceRepository.getAllEmployeeList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<AllEmployeeListModel> snapshot) {
                      if (snapshot.data == null) {
                        print("no data found");
                      } else {}

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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: borderColor, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: DropdownButton<String>(
                                  hint: Text("All Employee"),
                                  isExpanded: true,
                                  value: newEmployee,
                                  icon: Icon(Icons.arrow_drop_down_outlined),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String? value) {
// This is called when the user selects an item.
                                    setState(() {
                                      newEmployee = value!;
                                      snapshot.data!.results!
                                          .forEach((element) {
                                        if (newEmployee ==
                                            element.employeeName!) {
                                          employeeID = element.employeeId!;
                                          print(
                                              "employee id is${element.employeeName}" +
                                                  "$employeeID");
                                        }
                                      });
// assignToID = snapshot
//     .data!.result!["SelectListEmployee"]!.indexOf(newEmployee);
                                    });
                                  },
                                  items: snapshot.data!.results!.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.employeeName.toString(),
                                      child:
                                          Text(value.employeeName.toString()),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          }
                      }
                    },
                  ),
                  Expanded(
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
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownValue = value!;
                                      yearSelection = int.parse(dropdownValue);
                                    });
                                  },
                                  items: yearList.map<DropdownMenuItem<String>>(
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
                              child: DefaultTabController(
                                initialIndex: selectMonth - 1,
                                length: 12,
                                child: TabBar(
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          primaryColorSecond.withOpacity(.1)),
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
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                tab,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 500,
                          child: DefaultTabController(
                            initialIndex: 0,
                            length: 3,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 100,
                                  height: 40,
                                  child: TabBar(
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: borderColor, width: 1),
                                        color: primaryColorSecond.withOpacity(.1)),
                                    isScrollable: true,
                                    indicatorColor: Colors.black,
                                    labelColor: Colors.black,
                                    onTap: (index) {
                                      // setState((){
                                      //   selectMonth = index+1;
                                      // });
                                    },
                                     tabs: const [
                                    Tab(
                                    text: 'Claimed',
                                  ),
                                  Tab(
                                    text: 'Approved',
                                  ),
                                  Tab(
                                    text: 'All',
                                  ),

                                  ],
                                  ),
                                ),
                                Container(
                                  height:450,

                                  child: TabBarView(children: [
                                    FutureBuilder<GetAllExpenseModel>(
                                      future: expenseRepository
                                          .getAllExpense(), // async work
                                      builder: (BuildContext context,
                                          AsyncSnapshot<GetAllExpenseModel>
                                          snapshot) {
                                        totalBalance = 0;
                                        if (snapshot.data == null) {
                                          print("snapshot no data found");
                                        } else {
                                          // num sum = 0;
                                          // [1, 2, 3].forEach((num e){sum += e;});
                                          // print(sum);
                                          snapshot.data!.result!.forEach((element) {
                                            if (selectMonth ==
                                                int.parse(element.date
                                                    .toString()
                                                    .substring(5, 7)) &&
                                                yearSelection ==
                                                    int.parse(element.date
                                                        .toString()
                                                        .substring(0, 4))) {
                                              totalBalance += element.cost!;
                                              print("total amount is  $totalBalance");
                                            }
                                          });
                                        }

                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Center(
                                                child: LoadingAnimationWidget.twistingDots(
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
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Total: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                            // Text(' BDT',style: TextStyle(
                                                            //     color: Colors.grey.withOpacity(.5),
                                                            //     fontSize: 10
                                                            // ),)
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Approved: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Pending: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width:230,
                                                        child: CheckboxListTile(
                                                          value: check3,
                                                          controlAffinity: ListTileControlAffinity.leading, //checkbox at left
                                                          onChanged: (bool? value) {
                                                            setState(() {
                                                              check3 = value;
                                                            });
                                                          },
                                                          title: Text("Select All" +  " (0.0 bdt)",style: TextStyle(fontSize: 12, ),),
                                                        ),
                                                      ),

                                                      Spacer(),
                                                      check3 == true ?
                                                      GestureDetector(
                                                        onTap:(){


                                                          if(check3 == true){
                                                            snapshot.data!.result!.forEach((element) {
                                                              if(element.status == 0 &&
                                                                  selectMonth ==
                                                                      int.parse(element.date
                                                                          .toString()
                                                                          .substring(5, 7)) &&
                                                                  yearSelection ==
                                                                      int.parse(element.date
                                                                          .toString()
                                                                          .substring(0, 4)))
                                                                expenseRepository.changeStatusExpense(element.expenseID!, element.type!, element.status == 0 ? 1 : 0).then((value) => setState((){

                                                                }));
                                                            });

                                                          } else {
                                                            print("tapped error in all approve");
                                                          }
                                        },
                                                        child: Container(
                                                            height:
                                                            40,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                primaryColor,
                                                                borderRadius:
                                                                BorderRadius.all(Radius.circular(10.0))),
                                                            child: Center(
                                                                child: Text(
                                                                  "Approve All",
                                                                  style: TextStyle(
                                                                      color:
                                                                      Colors.white,
                                                                      fontSize: 12),
                                                                ))),
                                                      )
                                                          : Container(),
                                                    ],
                                                  ),


                                                  Container(
                                                    height:
                                                    MediaQuery.of(context).size.height -
                                                        550,
                                                    child: ListView.builder(
                                                        itemCount:
                                                        snapshot.data!.result!.length,
                                                        itemBuilder:
                                                            (BuildContext context, index) {
                                                          var data =
                                                          snapshot.data!.result![index];

                                                          if ( data.status == 0 &&
                                                              selectMonth ==
                                                                  int.parse(data.date
                                                                      .toString()
                                                                      .substring(5, 7)) &&
                                                              yearSelection ==
                                                                  int.parse(data.date
                                                                      .toString()
                                                                      .substring(0, 4))) {
                                                            return Card(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                                    border: Border.all(
                                                                        color: Colors.grey
                                                                            .withOpacity(
                                                                            .5)),
                                                                    color:check3 == true ? blue
                                                                        .withOpacity(.2) :   blue
                                                                        .withOpacity(.1)),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets.all(
                                                                      8.0),
                                                                  child: IntrinsicHeight(
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              getEmp(data!.empId!, AttendanceRepository.employeeList),),
                                                                            Text(
                                                                              getDeg(data.empId!, AttendanceRepository.employeeList),),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              getDepartment(data.empId!, AttendanceRepository.employeeList),
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  color:  Colors
                                                                                      .grey),
                                                                            ),
                                                                            Text(
                                                                              "Branch",
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  color:  Colors
                                                                                      .grey),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Divider(
                                                                          thickness: 1,
                                                                        ),
                                                                        SizedBox(
                                                                          height: 2,
                                                                        ),
                                                                        Container(
                                                                          child: Row(
                                                                            children: [
                                                                              Container(
                                                                                  height:
                                                                                  42,
                                                                                  decoration: BoxDecoration(
                                                                                      color: primaryColorSecond.withOpacity(
                                                                                          .3),
                                                                                      borderRadius: BorderRadius.circular(
                                                                                          6)),
                                                                                  width: 75,
                                                                                  child:
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.symmetric(vertical: 4.0),
                                                                                    child:
                                                                                    Column(
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Text(
                                                                                              DateFormat('EEEE').format(data.date!).toString().substring(0, 3) + ",",
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                                            Center(
                                                                                              child: Text(
                                                                                                " " + data.date.toString().substring(8, 10),
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(fontSize: 12),
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              DateFormat('MMM').format(data.date!),
                                                                                              style: TextStyle(fontSize: 12),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Card(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                DateFormat.jm().format(data.date!),
                                                                                                style: TextStyle(fontSize: 8),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )),
                                                                              const SizedBox(
                                                                                width: 3,
                                                                              ),
                                                                              Expanded(
                                                                                flex: 4,
                                                                                child: Row(
                                                                                  mainAxisAlignment:
                                                                                  MainAxisAlignment
                                                                                      .spaceBetween,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment:
                                                                                      CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      data.type!,
                                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                    ),
                                                                                                    Text(": "),
                                                                                                    const SizedBox(
                                                                                                      height: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      data.cost.toString(),
                                                                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      ' BDT',
                                                                                                      style: TextStyle(color:Colors.grey.withOpacity(.7)),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),

                                                                                            ],
                                                                                          ),
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
                                                                                          width: 140,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
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
                                                                              InkWell(
                                                                                onTap: (){
                                                                                  print("tapped");


                                                                                   expenseRepository.changeStatusExpense(data.expenseID!, data.type!, data.status == 0 ? 1 : 0).then((value) => setState((){

                                                                                   }));



                                                                                },
                                                                                child: Container(
                                                                                    height:
                                                                                    30,
                                                                                    width: 70,
                                                                                    decoration: BoxDecoration(
                                                                                        color:
                                                                                        primaryColor,
                                                                                        borderRadius:
                                                                                        BorderRadius.all(Radius.circular(10.0))),
                                                                                    child: Center(child: Text(
                                                                                      "Approve",
                                                                                      style: TextStyle(
                                                                                          color:
                                                                                          Colors.white,
                                                                                          fontSize: 12),
                                                                                    )
                                                                                    )),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
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
                                                            builder: (builder) => AllExPdfPreviewPage(invoice: snapshot.data!, monthSelection: selectMonth, yearSelection: 2023, ),
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
                                    FutureBuilder<GetAllExpenseModel>(
                                      future: expenseRepository
                                          .getAllExpense(), // async work
                                      builder: (BuildContext context,
                                          AsyncSnapshot<GetAllExpenseModel>
                                          snapshot) {
                                        totalBalance = 0;
                                        if (snapshot.data == null) {
                                          print("snapshot no data found");
                                        } else {
                                          // num sum = 0;
                                          // [1, 2, 3].forEach((num e){sum += e;});
                                          // print(sum);
                                          snapshot.data!.result!.forEach((element) {
                                            if (

                                            selectMonth ==
                                                int.parse(element.date
                                                    .toString()
                                                    .substring(5, 7)) &&
                                                yearSelection ==
                                                    int.parse(element.date
                                                        .toString()
                                                        .substring(0, 4))) {
                                              totalBalance += element.cost!;
                                              print("total amount is  $totalBalance");
                                            }
                                          });
                                        }

                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Center(
                                                child: LoadingAnimationWidget.twistingDots(
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
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Total: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                            // Text(' BDT',style: TextStyle(
                                                            //     color: Colors.grey.withOpacity(.5),
                                                            //     fontSize: 10
                                                            // ),)
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Approved: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Pending: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width:230,
                                                        child: CheckboxListTile(
                                                          value: check3,
                                                          controlAffinity: ListTileControlAffinity.leading, //checkbox at left
                                                          onChanged: (bool? value) {
                                                            setState(() {
                                                              check3 = value;
                                                            });
                                                          },
                                                          title: Text("Select All" +  " (0.0 bdt)",style: TextStyle(fontSize: 12, ),),
                                                        ),
                                                      ),

                                                      Spacer(),
                                                      check3 == true ?
                                                      Container(
                                                          height:
                                                          40,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              color:
                                                              primaryColor,
                                                              borderRadius:
                                                              BorderRadius.all(Radius.circular(10.0))),
                                                          child: Center(
                                                              child: Text(
                                                                "Approve All",
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.white,
                                                                    fontSize: 12),
                                                              )))
                                                          : Container(),
                                                    ],
                                                  ),


                                                  Container(
                                                    height:
                                                    MediaQuery.of(context).size.height -
                                                        550,
                                                    child: ListView.builder(
                                                        itemCount:
                                                        snapshot.data!.result!.length,
                                                        itemBuilder:
                                                            (BuildContext context, index) {
                                                          var data =
                                                          snapshot.data!.result![index];

                                                          if ( data.status == 1 &&
                                                          selectMonth ==
                                                              int.parse(data.date
                                                                  .toString()
                                                                  .substring(5, 7)) &&
                                                              yearSelection ==
                                                                  int.parse(data.date
                                                                      .toString()
                                                                      .substring(0, 4))) {
                                                            return Card(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                                    border: Border.all(
                                                                        color: Colors.grey
                                                                            .withOpacity(
                                                                            .5)),
                                                                    color:check3 == true ? blue
                                                                        .withOpacity(.2) :   blue
                                                                        .withOpacity(.1)),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets.all(
                                                                      8.0),
                                                                  child: IntrinsicHeight(
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              getEmp(data!.empId!, AttendanceRepository.employeeList),),
                                                                            Text(
                                                                              getDeg(data.empId!, AttendanceRepository.employeeList),),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              getDepartment(data.empId!, AttendanceRepository.employeeList),
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  color:  Colors
                                                                                      .grey),
                                                                            ),
                                                                            Text(
                                                                              "Branch",
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  color:  Colors
                                                                                      .grey),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Divider(
                                                                          thickness: 1,
                                                                        ),
                                                                        SizedBox(
                                                                          height: 2,
                                                                        ),
                                                                        Container(
                                                                          child: Row(
                                                                            children: [
                                                                              Container(
                                                                                  height:
                                                                                  42,
                                                                                  decoration: BoxDecoration(
                                                                                      color: primaryColorSecond.withOpacity(
                                                                                          .3),
                                                                                      borderRadius: BorderRadius.circular(
                                                                                          6)),
                                                                                  width: 75,
                                                                                  child:
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.symmetric(vertical: 4.0),
                                                                                    child:
                                                                                    Column(
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Text(
                                                                                              DateFormat('EEEE').format(data.date!).toString().substring(0, 3) + ",",
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                                            Center(
                                                                                              child: Text(
                                                                                                " " + data.date.toString().substring(8, 10),
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(fontSize: 12),
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              DateFormat('MMM').format(data.date!),
                                                                                              style: TextStyle(fontSize: 12),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Card(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                DateFormat.jm().format(data.date!),
                                                                                                style: TextStyle(fontSize: 8),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )),
                                                                              const SizedBox(
                                                                                width: 3,
                                                                              ),
                                                                              Expanded(
                                                                                flex: 4,
                                                                                child: Row(
                                                                                  mainAxisAlignment:
                                                                                  MainAxisAlignment
                                                                                      .spaceBetween,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment:
                                                                                      CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      data.type!,
                                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                    ),
                                                                                                    Text(": "),
                                                                                                    const SizedBox(
                                                                                                      height: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      data.cost.toString(),
                                                                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      ' BDT',
                                                                                                      style: TextStyle(color:Colors.grey.withOpacity(.7)),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),

                                                                                            ],
                                                                                          ),
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
                                                                                          width: 140,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
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
                                                                              InkWell(
                                                                                onTap: (){
                                                                                  print("tapped");

                                                                                     expenseRepository.changeStatusExpense(data.expenseID!, data.type!, data.status == 0 ? 1 : 0).then((value)
                                                                                     => setState((){

                                                                                     }));
                                                                                },
                                                                                child: Container(
                                                                                    height:
                                                                                    30,
                                                                                    width: 70,
                                                                                    decoration: BoxDecoration(
                                                                                        color:
                                                                                        Colors.redAccent,
                                                                                        borderRadius:
                                                                                        BorderRadius.all(Radius.circular(10.0))),
                                                                                    child: Center(child: Text(
                                                                                      "Disapprove",
                                                                                      style: TextStyle(
                                                                                          color:
                                                                                          Colors.white,
                                                                                          fontSize: 12),
                                                                                    )
                                                                                    )),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
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
                                                            builder: (builder) => AllExPdfPreviewPage(invoice: snapshot.data!, monthSelection: selectMonth, yearSelection: 2023, ),
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
                                    FutureBuilder<GetAllExpenseModel>(
                                      future: expenseRepository
                                          .getAllExpense(), // async work
                                      builder: (BuildContext context,
                                          AsyncSnapshot<GetAllExpenseModel>
                                          snapshot) {
                                        totalBalance = 0;
                                        if (snapshot.data == null) {
                                          print("snapshot no data found");
                                        } else {
                                          // num sum = 0;
                                          // [1, 2, 3].forEach((num e){sum += e;});
                                          // print(sum);
                                          snapshot.data!.result!.forEach((element) {
                                            if (selectMonth ==
                                                int.parse(element.date
                                                    .toString()
                                                    .substring(5, 7)) &&
                                                yearSelection ==
                                                    int.parse(element.date
                                                        .toString()
                                                        .substring(0, 4))) {
                                              totalBalance += element.cost!;
                                              print("total amount is  $totalBalance");
                                            }
                                          });
                                        }

                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Center(
                                                child: LoadingAnimationWidget.twistingDots(
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
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Total: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                            // Text(' BDT',style: TextStyle(
                                                            //     color: Colors.grey.withOpacity(.5),
                                                            //     fontSize: 10
                                                            // ),)
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Approved: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5.0, vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Pending: ',
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              totalBalance.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     Container(
                                                  //       height: 40,
                                                  //       width:230,
                                                  //       child: CheckboxListTile(
                                                  //         value: check3,
                                                  //         controlAffinity: ListTileControlAffinity.leading, //checkbox at left
                                                  //         onChanged: (bool? value) {
                                                  //           setState(() {
                                                  //             check3 = value;
                                                  //           });
                                                  //         },
                                                  //         title: Text("Select All" +  " (0.0 bdt)",style: TextStyle(fontSize: 12, ),),
                                                  //       ),
                                                  //     ),
                                                  //
                                                  //     Spacer(),
                                                  //     check3 == true ?
                                                  //     Container(
                                                  //         height:
                                                  //         40,
                                                  //         width: 100,
                                                  //         decoration: BoxDecoration(
                                                  //             color:
                                                  //             primaryColor,
                                                  //             borderRadius:
                                                  //             BorderRadius.all(Radius.circular(10.0))),
                                                  //         child: Center(
                                                  //             child: Text(
                                                  //               "Approve All",
                                                  //               style: TextStyle(
                                                  //                   color:
                                                  //                   Colors.white,
                                                  //                   fontSize: 12),
                                                  //             )))
                                                  //         : Container(),
                                                  //   ],
                                                  // ),


                                                  Container(
                                                    height:
                                                    MediaQuery.of(context).size.height -
                                                        550,
                                                    child: ListView.builder(
                                                        itemCount:
                                                        snapshot.data!.result!.length,
                                                        itemBuilder:
                                                            (BuildContext context, index) {
                                                          var data =
                                                          snapshot.data!.result![index];

                                                          if (
                                                          selectMonth ==
                                                              int.parse(data.date
                                                                  .toString()
                                                                  .substring(5, 7)) &&
                                                              yearSelection ==
                                                                  int.parse(data.date
                                                                      .toString()
                                                                      .substring(0, 4))) {
                                                            return Card(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                                    border: Border.all(
                                                                        color: Colors.grey
                                                                            .withOpacity(
                                                                            .5)),
                                                                    color:check3 == true ? blue
                                                                        .withOpacity(.2) :   blue
                                                                        .withOpacity(.1)),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets.all(
                                                                      8.0),
                                                                  child: IntrinsicHeight(
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              getEmp(data!.empId!, AttendanceRepository.employeeList),),
                                                                            Text(
                                                                              getDeg(data.empId!, AttendanceRepository.employeeList),),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              getDepartment(data.empId!, AttendanceRepository.employeeList),
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  color:  Colors
                                                                                      .grey),
                                                                            ),
                                                                            Text(
                                                                              "Branch",
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  color:  Colors
                                                                                      .grey),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Divider(
                                                                          thickness: 1,
                                                                        ),
                                                                        SizedBox(
                                                                          height: 2,
                                                                        ),
                                                                        Container(
                                                                          child: Row(
                                                                            children: [
                                                                              Container(
                                                                                  height:
                                                                                  42,
                                                                                  decoration: BoxDecoration(
                                                                                      color: primaryColorSecond.withOpacity(
                                                                                          .3),
                                                                                      borderRadius: BorderRadius.circular(
                                                                                          6)),
                                                                                  width: 75,
                                                                                  child:
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.symmetric(vertical: 4.0),
                                                                                    child:
                                                                                    Column(
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Text(
                                                                                              DateFormat('EEEE').format(data.date!).toString().substring(0, 3) + ",",
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                                            Center(
                                                                                              child: Text(
                                                                                                " " + data.date.toString().substring(8, 10),
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(fontSize: 12),
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              DateFormat('MMM').format(data.date!),
                                                                                              style: TextStyle(fontSize: 12),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Card(
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                DateFormat.jm().format(data.date!),
                                                                                                style: TextStyle(fontSize: 8),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )),
                                                                              const SizedBox(
                                                                                width: 3,
                                                                              ),
                                                                              Expanded(
                                                                                flex: 4,
                                                                                child: Row(
                                                                                  mainAxisAlignment:
                                                                                  MainAxisAlignment
                                                                                      .spaceBetween,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment:
                                                                                      CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      data.type!,
                                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                    ),
                                                                                                    Text(": "),
                                                                                                    const SizedBox(
                                                                                                      height: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      data.cost.toString(),
                                                                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      ' BDT',
                                                                                                      style: TextStyle(color:Colors.grey.withOpacity(.7)),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),

                                                                                            ],
                                                                                          ),
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
                                                                                          width: 140,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
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
                                                                              InkWell(
                                                                                onTap: (){
                                                                                  print("tapped");

                                                                                  //expenseRepository.changeStatusExpense(data.expenseID!, data.type!, data.status == 0 ? 1 : 0);
                                                                                },
                                                                                child: Container(
                                                                                    height:
                                                                                    30,
                                                                                    width: 70,
                                                                                    decoration: BoxDecoration(
                                                                                        color:
                                                                                        data.status == 0 ? Colors.cyan : Colors.grey,
                                                                                        borderRadius:
                                                                                        BorderRadius.all(Radius.circular(10.0))),
                                                                                    child: Center(child: data.status == 0 ?
                                                                                    Text(
                                                                                      "Claimed",
                                                                                      style: TextStyle(
                                                                                          color:
                                                                                          Colors.white,
                                                                                          fontSize: 12),
                                                                                    ) : Text(
                                                                                      "Approved",
                                                                                      style: TextStyle(
                                                                                          color:
                                                                                          Colors.white,
                                                                                          fontSize: 12),
                                                                                    )
                                                                                    )),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
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
                                                        print("tapped");
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (builder) => AllExPdfPreviewPage(invoice: snapshot.data!, monthSelection: selectMonth, yearSelection: 2023, ),
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
                                  ]),
                                )
                              ],
                            ),



                       ),
                        ),

                      ],
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

  getEmp(int id, List<Results> list) {
    List<Results> p = [];
    p.add(list.where((element) => element.employeeId == id).first);
    return p[0].employeeName;
  }
  getDeg(int id, List<Results> list) {
    List<Results> p = [];
    p.add(list.where((element) => element.employeeId == id).first);
    return p[0].designationObj!.designationName;
  }
  getDepartment(int id, List<Results> list) {
    List<Results> p = [];
    p.add(list.where((element) => element.employeeId == id).first);
    return p[0].departmentObj!.departmentName;
  }
}
