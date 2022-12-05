import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/MenuPage/employee_list/employee_list.dart';
import 'package:salebee/bottomNav.dart';
import 'package:salebee/utils.dart';

class MenusScreen extends StatefulWidget {
  const MenusScreen({Key? key}) : super(key: key);

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLight,
      appBar: AppBar(
        backgroundColor: primaryColorLight,
        title: Text("All Menu",
        style: TextStyle(
          color: Colors.black54
        ),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),

      body: Column(
        children: [
          Container(height: 20,),
          Container(
            height: MediaQuery.of(context).size.height -120,
            child:  GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                Card(
                  elevation: 10,

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text("Dashboard")),
                    ],
                  ),
                ),
                Card(
                  elevation: 10,
                  color: Colors.teal[100],
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/eye.png',
                        ),
                      ),
                      Center(child: const Text('The Eye')),
                    ],
                  ),
                ),
                Card(
                  elevation: 10,
                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(  'images/Icons/listview.png',)

                          ),
                        ),

                      ),
                      Center(child: const Text('Prospect List')),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(EmployeeList());
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(  'images/Icons/listview.png',)

                            ),
                          ),

                        ),
                        Center(child: const Text('Employee List')),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(  'images/Icons/salary_expense.png',)

                          ),
                        ),

                      ),
                      Center(child: const Text('Employee List')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Setting')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
                Card(

                  color: Colors.teal[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage:
                        AssetImage(
                          'images/dash.png',
                        ),
                      ),
                      Center(child: const Text('Monthly Report')),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      )
    );
  }
}
