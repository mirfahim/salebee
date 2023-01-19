import 'package:flutter/material.dart';

import '../../utils.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Container(
                    height: 100,
                    child: Column(
                      children: [
                        Text("Balance: 1000"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cash In: 1000"),
                            Text("Expense: 1000"),
                          ],
                        )
                      ],
                    ),


                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 60,
                 width: 200,
                  child: TabBar(


                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColorSecond.withOpacity(.5)),
                    isScrollable: true,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,


                    onTap: (index){
                      // setState((){
                      //   selectMonth = index+1;
                      // });

                    },
                    tabs:  [
                      Tab(icon: Icon(Icons.monetization_on_outlined), text: 'Cash In'),
                      Tab(icon: Icon(Icons.money_off), text: 'Expense'),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: TabBarView(
                    children: [
                      // Add widgets for each tab here
                      Container(
                        height: 100,
                        child: Center(
                          child: Text('Home Tab'),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text('Settings Tab'),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
