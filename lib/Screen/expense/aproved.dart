import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Screen/expense/expense_create/expense_create_front.dart';
import 'package:salebee/Screen/expense/expense_create/other_expense.dart';
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

class Approved extends StatefulWidget {
  const Approved({Key? key}) : super(key: key);

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  ExpenseRepository expenseRepository = ExpenseRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      'Total Balance: ',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const Text(
                      '1000',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    Text(
                      ' BDT',
                      style: TextStyle(
                          color: Colors.grey.withOpacity(.5), fontSize: 20),
                    )
                  ],
                ),
              ),
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
                      FutureBuilder<GetTransportExpenseModel>(
                        future: expenseRepository
                            .getTransportExpense(), // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<GetTransportExpenseModel> snapshot) {
                          if (snapshot.data == null) {
                            print("snapshot no data found");
                          } else {
                            print(
                                "snapshot data is ${snapshot.data!.result!.length}");
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
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height - 300,
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.result!.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(.5)),
                                              color: blue.withOpacity(.1)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Image.asset(
                                                    'images/food.png',
                                                    height: 30,
                                                  )),
                                                  const VerticalDivider(
                                                    thickness: 1,
                                                    color: Colors.grey,
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
                                                            const Text('Lunch'),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              '30 July 2022',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          .7)),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  '250',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Text(
                                                                  ' BDT',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              .7)),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          size: 14,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
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
                Get.to(ExpenseCreateFront(page: "transport"));
              },
              child: Container(
                height: 48,
                width: size.width,
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
    );
  }
}
