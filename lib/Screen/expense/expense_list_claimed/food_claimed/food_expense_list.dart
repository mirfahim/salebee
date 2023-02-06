import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Model/expense/get_expense_food_model.dart';
import 'package:salebee/Screen/expense/expense_create/expense_create_front.dart';
import 'package:salebee/Screen/expense/expense_create/other_expense.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/food_claimed/expense_pdf_preview_food.dart';
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

class FoodClaimedList extends StatefulWidget {
  const FoodClaimedList({Key? key}) : super(key: key);

  @override
  State<FoodClaimedList> createState() => _ApprovedState();
}

class _ApprovedState extends State<FoodClaimedList> {
  ExpenseRepository expenseRepository = ExpenseRepository();
  List expenseList = [];
  List<String> type = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
  List<String> yearList = <String>[DateTime.now().year.toString(), DateTime(DateTime.now().year-1).toString().substring(0,4), DateTime(DateTime.now().year-2).toString().substring(0,4) ];
  String dropdownValue = DateTime.now().year.toString();

  int yearSelection = int.parse(DateTime.now().toString().substring(0,4));
  String vehicleName = "";
  double totalBalance = 0.0;
  int selectMonth = int.parse(DateTime.now().toString().substring(5, 7));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primaryColorLight,
        appBar: AppBar(
          backgroundColor: primaryColorLight,
          title: Text(
            "Food Expense Claimed",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
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

                              Container(
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
                            ],
                          ),
                          FutureBuilder<GetFoodExpenseModel>(
                            future: expenseRepository
                                .getFoodExpense(), // async work
                            builder: (BuildContext context,
                                AsyncSnapshot<GetFoodExpenseModel> snapshot) {
                              totalBalance = 0 ;
                              if (snapshot.data == null) {
                                print("snapshot no data found");
                              } else {
                                snapshot.data!.result!.forEach((element) {
                                  if(selectMonth == int.parse(element.createdOn.toString().substring(5,7)) && yearSelection == int.parse(element.createdOn.toString().substring(0,4))){
                                    expenseList.add(element.expense);

                                    totalBalance =  expenseList.fold(0, (previousValue, element) =>previousValue + element);
                                    print("total amount is  $totalBalance");}

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
                                                if (data.mealType == 0) {
                                                  vehicleName = type[0];
                                                }
                                                if (data.mealType == 1) {
                                                  vehicleName = type[1];
                                                }
                                                if (data.mealType == 2) {
                                                  vehicleName = type[2];
                                                }
                                                if (data.mealType == 3) {
                                                  vehicleName = type[3];
                                                }
                                                if (data.mealType == 4) {
                                                  vehicleName = type[4];
                                                }

                                                if(selectMonth ==
                                                    int.parse(data.createdOn
                                                        .toString()
                                                        .substring(5, 7)) && yearSelection ==  int.parse(data.createdOn
                                                    .toString()
                                                    .substring(0, 4))){
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            10),
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey
                                                                .withOpacity(
                                                                .5)),
                                                        color: blue
                                                            .withOpacity(
                                                            .1)),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child:
                                                      IntrinsicHeight(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                height: 40,
                                                                decoration: BoxDecoration(
                                                                    color: primaryColorSecond.withOpacity(
                                                                        .3),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        6)),
                                                                width: 70,
                                                                child:
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      4.0),
                                                                  child:
                                                                  Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            DateFormat('EEEE').format(data.createdOn!).toString().substring(0, 3) + ",",
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                          Center(
                                                                            child: Text(
                                                                              " " + data.createdOn.toString().substring(8, 10),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontSize: 11),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            DateFormat('MMM').format(data.createdOn!).toString().substring(0, 3),
                                                                            style: TextStyle(fontSize: 11),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Card(
                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              DateFormat.jm().format(data.createdOn!),
                                                                              style: TextStyle(fontSize: 7),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                            const VerticalDivider(
                                                              thickness: 1,
                                                              color: Colors
                                                                  .grey,
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
                                                                    CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(vehicleName + ": "),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                data.expense.toString(),
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                                              ),
                                                                              Text(
                                                                                ' BDT',
                                                                                style: TextStyle(color: Colors.grey.withOpacity(.7)),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Person no: ",
                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                                                          ),
                                                                          Text(
                                                                            '${data.person}',
                                                                            style: TextStyle(color: Colors.grey.withOpacity(.7)),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                        220,
                                                                        child:
                                                                        Expanded(
                                                                          child: Text("${data.description} ,", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.withOpacity(.7))),
                                                                        ),
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
                                                      PdfPreviewPage(
                                                          invoice:
                                                              snapshot.data!,
                                                        monthSelection: selectMonth, yearSelection: yearSelection,
                                                      expenselist: expenseList,),
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
                    Get.to(ExpenseCreateFront(page: "food",));
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
