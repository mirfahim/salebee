import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/expense/aproved.dart';
import 'package:salebee/Screen/expense/claimed.dart';
import 'package:salebee/Screen/expense/pending.dart';
import 'package:salebee/utils.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: primaryColorLight,
        appBar: AppBar(
          title: const Text('Expense',style: TextStyle(
            color: Colors.black,fontWeight: FontWeight.w600
          ),),
          automaticallyImplyLeading: true,
          backgroundColor: primaryColorLight,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          actions: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150),
              ),
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.person,color: darkBlue,),
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
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
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: 'Approved',
                          ),
                          Tab(
                            text: 'Claimed',
                          ),
                          Tab(
                            text: 'Pending',
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Approved(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Claimed(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Pending(),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
