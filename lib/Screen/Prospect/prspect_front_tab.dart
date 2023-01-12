import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/Prospect/individual_prospect.dart';
import 'package:salebee/Screen/Prospect/organization_prospect.dart';
import 'package:salebee/utils.dart';
import 'package:salebee/Screen/leave/granted.dart';
import 'package:salebee/Screen/leave/applied.dart';

class ProspectFront extends StatelessWidget {
  const ProspectFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(


          title:  Text('Prospect',style: TextStyle(
              color: appBarHeader,fontSize: 24
          ),),
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          backgroundColor: primaryColorLight,
          elevation: 0,
          centerTitle: true,

        ),
        body:

        Container(
          color: primaryColorLight,
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
                              text: 'Individual Prospect',
                            ),
                            Tab(
                              text: 'Organization Prospect',
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
                          child: IndividualProspect(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: OrganizationProspect(),
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
