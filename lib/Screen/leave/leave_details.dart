import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils.dart';

class LeaveDetails extends StatelessWidget {
  const LeaveDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: const Text('Leave Details',style: TextStyle(
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: primaryColorLight.withOpacity(.6),
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
                        child: Text('Status'),
                      ),
                      Flexible(
                        flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.orange
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                              child: Text('Pending'),
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Requested On'),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('3 Jul | 08:22 PM'),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Type'),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('Annual Leave'),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Period'),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('Jul 3 - Jul 5'),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Total Days'),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('3 Days'),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Note'),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('I need 3 days sick leave'),
                                Icon(Icons.edit,color: primaryColor,)
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Substitute'),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('N/A'),
                                Icon(Icons.edit,color: primaryColor,)
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1,color: Colors.grey,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Approvers'),
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
                                    Text('Mohammad Kamal'),
                                    Text('Md. Hafizur Rahaman')
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orange
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                                    child: Text('Pending'),
                                  ),
                                )
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(thickness: 1,color: Colors.grey,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
