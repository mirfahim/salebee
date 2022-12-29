import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils.dart';

class ProspectDetails extends StatelessWidget {
  const ProspectDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      appBar: AppBar(

        title:  Text('Prospect Details',style: TextStyle(
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
                        child: Text('Name',style: TextStyle(
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
                              child: Text('',style: TextStyle(
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
                        child: Text('Stage',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('',style: TextStyle(
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
                        child: Text('Industry',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('',style: TextStyle(
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
                        child: Text('Prospect for',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('',style: TextStyle(
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
                        child: Text('Created by',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text('',style: TextStyle(
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
                        child: Text('Created on',style: TextStyle(
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
                                Text('',style: TextStyle(
                                    fontSize: 12, color: text, fontWeight: FontWeight.w600
                                ),),

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
                        child: Text('Created by',style: TextStyle(
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
                        child: Text('Assign to',style: TextStyle(
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

                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  Container(
                      child: Column(
                        children: [

                          Container(
                            height: 20,
                            color:
                            primaryColor,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      4,
                                  child: Text(
                                    "Contact person",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      4,
                                  child: Text(
                                    "Designation",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      4,
                                  child: Text(
                                    "Mobile",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      )
                  ),
                  Container(
                    height: 80,
                    child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext  context, int  index){


                          return Container(
                            height: 40,
                            color:
                            Colors.white,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                               Container(
                                  width:
                                  MediaQuery.of(context).size.width / 4,
                                  child:
                                  Text(
                                    "No Data",
                                    style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),

                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.5,
                                  child:
                                  Text(
                                    "No Data",
                                    style:
                                    TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 4,
                                  child:
                                  Text(
                                    "No Data",
                                    style:
                                    TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                )

                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Important note',style: TextStyle(
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
                                    Text('ff ff',style: TextStyle(
                                        fontSize: 12, color: text, fontWeight: FontWeight.w600
                                    ),),
                                    Text('fff ff',style: TextStyle(
                                        fontSize: 12, color: text, fontWeight: FontWeight.w600
                                    ),)
                                  ],
                                ),

                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
