import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils.dart';

class LeaveDetails extends StatelessWidget {
  const LeaveDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      appBar: AppBar(

        title:  Text('Leave Details',style: TextStyle(
            color: appBarHeader,fontSize: 24,

        ),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        backgroundColor: backgroudColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            // color: primaryColorLight.withOpacity(.6),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Status',style: TextStyle(
                          color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                        flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFFFEDD5)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                              child: Text('Pending',style: TextStyle(
                                color: Color(0xFFEA580C),fontSize: 10, fontWeight: FontWeight.w600
                              ),),
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Requested On',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('3 Jul | 08:22 PM',style: TextStyle(
                              fontSize: 12, color: text, fontWeight: FontWeight.w600
                            ),),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Type',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('Annual Leave',style: TextStyle(
                                fontSize: 12, color: text, fontWeight: FontWeight.w600
                            ),),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Period',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('Jul 3 - Jul 5',style: TextStyle(
                                fontSize: 12, color: text, fontWeight: FontWeight.w600
                            ),),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Total Days',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('3 Days',style: TextStyle(
                                fontSize: 12, color: text, fontWeight: FontWeight.w600
                            ),),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Note',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('I need 3 days sick leave',style: TextStyle(
                                    fontSize: 12, color: text, fontWeight: FontWeight.w600
                                ),),
                                Image.asset('images/edit.png')
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Substitute',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('N/A',style: TextStyle(
                                    fontSize: 12, color: text, fontWeight: FontWeight.w600
                                ),),
                                Image.asset('images/edit.png')
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Approvers',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Mohammad Kamal',style: TextStyle(
                                        fontSize: 12, color: text, fontWeight: FontWeight.w600
                                    ),),
                                    Text('Md. Hafizur Rahaman',style: TextStyle(
                                        fontSize: 12, color: text, fontWeight: FontWeight.w600
                                    ),)
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFEDD5)
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                                    child: Text('Pending',style: TextStyle(
                                        color: Color(0xFFEA580C),fontSize: 10, fontWeight: FontWeight.w600
                                    ),),
                                  ),
                                )
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
