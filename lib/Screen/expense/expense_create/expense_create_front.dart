import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/Prospect/individual_prospect.dart';
import 'package:salebee/Screen/Prospect/organization_prospect.dart';
import 'package:salebee/Screen/expense/expense_create/food.dart';
import 'package:salebee/Screen/expense/expense_create/other_expense.dart';
import 'package:salebee/Screen/expense/expense_create/transport.dart';
import 'package:salebee/utils.dart';
import 'package:salebee/Screen/leave/granted.dart';
import 'package:salebee/Screen/leave/applied.dart';

class ExpenseCreateFront extends StatelessWidget {
  const ExpenseCreateFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(

          title:  Text('Expense Create',style: TextStyle(
              color: appBarHeader,fontSize: 24
          ),),
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          backgroundColor: const Color(0xFFE5E5E5),
          elevation: 0,
          centerTitle: true,

        ),
        body: Container(
          color: const Color(0xFFE5E5E5),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TabBar(
                          indicatorColor: darkBlue,
                          labelColor: darkBlue,
                          unselectedLabelColor: tabBarUnSelectedColor,
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 12
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600
                          ),
                          isScrollable: true,
                          tabs: const [
                            Tab(
                              text: 'Food Expense',
                            ),
                            Tab(
                              text: 'Transport Expense',
                            ),
                            Tab(
                              text: 'Other Expense',
                            ),

                          ],
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
                 Expanded(
                  child: TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: FoodExpense(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TransportExpenseCreatePage(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: OtherExpenseCreate(),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
