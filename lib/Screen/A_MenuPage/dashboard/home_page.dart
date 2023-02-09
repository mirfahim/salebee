
import 'package:flutter/material.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/expense_graph.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/expense_income.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/progress_chart.dart';
import 'package:salebee/Screen/A_MenuPage/dashboard/visa_card.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _HomePageState();
}

class _HomePageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              children: [
                const Text(
                  "History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.grey.shade500,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: const [
              VisaCardDesign(),
              ExpenseIncomeData(),
            ],
          ),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: SizedBox(
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Analytics",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const ExpenseGraphDesign(),
                  const CircleProgressChart(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.pink.withOpacity(0.6)),
                      ),
                      child: BottomNavigationBar(
                        showSelectedLabels: false,
                        items: [
                          BottomNavigationBarItem(
                            backgroundColor: Colors.grey.shade900,
                            icon: const Icon(Icons.bar_chart, color: Colors.grey),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: Colors.grey.shade900,
                            icon: const Icon(Icons.add_card, color: Colors.grey),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: Colors.grey.shade900,
                            icon: const Icon(Icons.notifications, color: Colors.grey),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: Colors.grey.shade900,
                            icon: const Icon(Icons.settings, color: Colors.grey),
                            label: "",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
