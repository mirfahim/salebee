import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/follow_up/add_followup_log.dart';
import 'package:salebee/Screen/follow_up/follow_up_list.dart';

import '../../Model/prospect/get_prospectList_by_id_model.dart';
import '../../utils.dart';

class ProspectDetails extends StatefulWidget {
  var data;
  String? prospectName;
  String? stage;
  String? industry;
  String? createdby;
  DateTime? createdOn;
  String? assignto;
  List<ConcernPerson>? concernPerson;
  String? note;
  int? prospectId;

   ProspectDetails({Key? key,this.prospectId, this.data, this.stage, this.prospectName, this.concernPerson, this.createdOn,this.assignto, this.createdby, this.industry, this.note} ) : super(key: key);

  @override
  State<ProspectDetails> createState() => _ProspectDetailsState();
}

class _ProspectDetailsState extends State<ProspectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLight,
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
        backgroundColor: primaryColorLight,
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
                        child: Text('Prospect:',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text(widget.prospectName!,style: TextStyle(
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
                        child: Text('Stage:',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text(widget.stage!,style: TextStyle(
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
                        child: Text('Industry:',style: TextStyle(
                            color: text,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text(widget.industry!,style: TextStyle(
                                fontSize: 12, color: text, fontWeight: FontWeight.w600
                            ),),
                          )
                      )
                    ],
                  ),
                  // const SizedBox(height: 5,),
                  // const Divider(thickness: 1,color: Colors.grey,),
                  // const SizedBox(height: 5,),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text('Prospect for:',style: TextStyle(
                  //           color: text,fontSize: 12, fontWeight: FontWeight.w400
                  //       ),),
                  //     ),
                  //     Flexible(
                  //         flex: 3,
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  //           child: Text('',style: TextStyle(
                  //               fontSize: 12, color: text, fontWeight: FontWeight.w600
                  //           ),),
                  //         )
                  //     )
                  //   ],
                  // ),


                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Created on:',style: TextStyle(
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
                                Text("${DateFormat.yMMM().format(widget.createdOn!)}",style: TextStyle(
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
                        child: Text('Created by:',style: TextStyle(
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
                                Text(widget.createdby!,style: TextStyle(
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
                        child: Text('Assign to:',style: TextStyle(
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
                                    Text(widget.assignto!,style: TextStyle(
                                        fontSize: 12, color: text, fontWeight: FontWeight.w600
                                    ),),

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Concern Person: ',style: TextStyle(
                              color: text,fontSize: 12, fontWeight: FontWeight.w400
                          ),),
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
                        itemCount: widget.concernPerson!.length,
                        itemBuilder: (BuildContext  context, int  index){
                          var concern = widget.concernPerson![index];


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
                                    concern.name!,
                                    style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),

                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.5,
                                  child:
                          concern.designation == null ?
                                  Text(
                                    "No Data",
                                    style:
                                    TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ):
                          Text(
                            concern.designation!,
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
                          concern.mobile == null?
                                  Text(
                                    concern.mobile!,
                                    style:
                                    TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  )
                                  : Text(
                            concern.mobile!,
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
                      Text('Important note: ',style: TextStyle(
                          color: text,fontSize: 12, fontWeight: FontWeight.w400
                      ),),
                      Container(
                        width: MediaQuery.of(
                            context)
                            .size
                            .width *
                            .6,
                        child: Text(widget.note!,
                          style: TextStyle(
                            fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal,

                        ),
                          maxLines: 4,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      Get.to(AddLogFollowUp(prospectID: widget.prospectId, prospect: widget.prospectName,));
                    },
                    child: Container(
                      height: 30,
                      width: 120,

                        decoration:  BoxDecoration(

                            shape: BoxShape.rectangle,
                            color: primaryColor,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10.0))),


                      child: Center(child: Text("Add Followup", style: TextStyle(fontSize: 12, color: Colors.white),)),
                    ),
                  ),
                  Container(
                    height: 300,
                      child: FollowUpList(prospectId: widget.prospectId,)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
