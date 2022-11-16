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
        color: const Color(0xFFE5E5E5),
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
        color: backgroudColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                InkWell(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('5 Jul - 7 Jul | 2022',style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: appBarHeader
                              ),),
                              const SizedBox(height: 10,),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text('3 days |',style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                  )),
                                  SizedBox(width: 5,),
                                  Text('Pending',style: TextStyle(
                                      color: Color(0xFFEA580C),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),)
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.arrow_forward_ios_outlined,color: Color(0xFF7C8DB5),))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('20 Mar - 27 Mar | 2022',style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: appBarHeader
                            ),),
                            const SizedBox(height: 10,),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text('3 days |',style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                )),
                                SizedBox(width: 5,),
                                Text('Not Granted',style: TextStyle(
                                    color: Color(0xFFDC2626),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),)
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.arrow_forward_ios_outlined,color: Color(0xFF7C8DB5)))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
