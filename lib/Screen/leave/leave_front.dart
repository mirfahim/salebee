import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/utils.dart';
import 'package:salebee/Screen/leave/granted.dart';
import 'package:salebee/Screen/leave/applied.dart';

class LeaveFront extends StatelessWidget {
  const LeaveFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          
          title: const Text('Leave',style: TextStyle(
              color: Colors.black,fontSize: 22
          ),),
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          backgroundColor: primaryColorLight.withOpacity(.6),
          elevation: 0,
          centerTitle: true,
          actions: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150)
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
                            text: 'Granted',
                          ),
                          Tab(
                            text: 'Applied',
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
                        child: Granted(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Applied(),
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
