import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils.dart';


class SelectSubtitute extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroudColor,
      appBar: AppBar(
        backgroundColor: backgroudColor,
        title:  Text('Select Substitute',style: TextStyle(
            color: appBarHeader,fontSize: 24
        ),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: backgroudColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Expanded(
                    child: DefaultTabController(
                      length: 12,
                      child: Column(
                        children: [
                          TabBar(
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFF617692)),
                                color: const Color(0xFF617692)),
                            labelPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 2),
                            isScrollable: true,
                            // indicatorColor: Colors.black,
                            labelColor: Colors.white,
                            unselectedLabelColor: const Color(0xFF617692),
                            unselectedLabelStyle: const TextStyle(
                              color: Color(0xFF617692)
                            ),
                            tabs: tabs
                                .map((tab) => Tab(
                              height: 24,
                              text: tab,
                            ))
                                .toList(),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF44C5E2),width: 2),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
                              child: Text('No Substitute Needed',style: TextStyle(
                                color: Color(0xFF0C162C)
                              ),),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0),
                              child: TabBarView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                // physics: NeverScrollableScrollPhysics(),
                                children: tabs
                                    .map((e) => SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('CXO'),
                                      const SizedBox(height: 10,),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: const Color(0xFF617692))
                                                ),
                                              ),
                                              const Expanded(
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage('images/person.jpg',),
                                                  ),
                                                  title: Text('Mohammad Kamal'),
                                                  subtitle: Text('MD & CEO'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: const Color(0xFF617692))
                                                ),
                                              ),
                                              const Expanded(
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage('images/person.jpg',),
                                                  ),
                                                  title: Text('Mohammad Kamal'),
                                                  subtitle: Text('MD & CEO'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      const Text('Accounts'),
                                      const SizedBox(height: 10,),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: const Color(0xFF617692))
                                                ),
                                              ),
                                              const Expanded(
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage('images/person.jpg',),
                                                  ),
                                                  title: Text('Mohammad Kamal'),
                                                  subtitle: Text('MD & CEO'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      const Text('Executive'),
                                      const SizedBox(height: 10,),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: const Color(0xFF617692))
                                                ),
                                              ),
                                              const Expanded(
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage('images/person.jpg',),
                                                  ),
                                                  title: Text('Mohammad Kamal'),
                                                  subtitle: Text('MD & CEO'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: const Color(0xFF617692))
                                                ),
                                              ),
                                              const Expanded(
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage('images/person.jpg',),
                                                  ),
                                                  title: Text('Mohammad Kamal'),
                                                  subtitle: Text('MD & CEO'),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: 58 ,
            color: const Color(0xFFE5E5E5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: (){
                  // Get.to(LeaveRequestSucceed());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: darkBlue
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Select substitute',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
