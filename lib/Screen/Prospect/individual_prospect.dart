import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/Prospect/create_prospect/create_prospect.dart';
import 'package:salebee/Screen/Prospect/create_prospect/create_prospect_front.dart';
import 'package:salebee/Screen/leave/leave_details.dart';
import 'package:salebee/utils.dart';



class IndividualProspect extends StatelessWidget {
  const IndividualProspect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 58 ,
        color: primaryColorLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: (){
              Get.to( CreateProspectFront());
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: darkBlue
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Create Prospect',
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
      body: Container(
        height: size.height,
        color: primaryColorLight,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -200,
              child: ListView.builder(
                itemCount: 4,
                  itemBuilder: (BuildContext context , index){
                  return  InkWell(
                    onTap: (){
                      Get.to(const LeaveDetails());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xFFFFFFFF)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Pro -01920',style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.grey
                                ),),
                                const SizedBox(height: 10,),
                                Text('25 Aug 2022',style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                )),

                                  ],
                                ),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 12,
                              ),
                              title:Text('Nexzen Solution',style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.black
                              ),),
                              subtitle: Text('Software Solution | Mirpur DOHS',style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.grey
                              ),),
                              trailing: Icon(
                              Icons.more_vert,
                              ),
                            ),
                              ],
                            ),



                      ),
                    ),
                  );
                  }),
            )

          ),
        ),
      ),
    );
  }
}
