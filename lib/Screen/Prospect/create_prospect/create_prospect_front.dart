import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/Prospect/create_prospect/contact_person.dart';
import 'package:salebee/Screen/Prospect/create_prospect/initial_info.dart';
import 'package:salebee/Screen/Prospect/create_prospect/organization_info.dart';
import 'package:salebee/Screen/Prospect/individual_prospect.dart';
import 'package:salebee/Screen/Prospect/organization_prospect.dart';
import 'package:salebee/utils.dart';
import 'package:salebee/Screen/leave/granted.dart';
import 'package:salebee/Screen/leave/applied.dart';

class CreateProspectFront extends StatelessWidget {
  const CreateProspectFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
          backgroundColor:primaryColorLight,
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
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset('images/user_icon.png'),
                ),
              ),
            )
          ],
        ),
        body: Container(
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
                              text: 'Initial',
                            ),
                            Tab(
                              text: 'Contact Person',
                            ),
                            Tab(
                              text: 'Organization Address',
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
                          child: CreateInitialProspect(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: CreateContactPersonProspect(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: CreateOrganizationProspect(),
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
