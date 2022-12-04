import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/utils.dart';

class TaskFollowUp extends StatelessWidget {
  const TaskFollowUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLight,
      appBar: AppBar(
        title: const Text('Follow Up',style: TextStyle(
            color: Colors.black,fontSize: 22
        ),),
        automaticallyImplyLeading: true,
        backgroundColor: primaryColorLight,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
            // Get.to(TestMyApp());
            // _autoCompleteTextField();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        // actions: [
        //   Card(
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(150)
        //     ),
        //     child: Container(
        //       decoration: const BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Colors.white
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Icon(Icons.person,color: darkBlue,),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: darkBlue,
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Today',style: TextStyle(
                                color: Colors.white,fontSize: 16
                            ),),
                          ),
                        ),),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text('Mark as Read', style: TextStyle(
                            color: darkBlue
                        ),),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset('images/checklist.png',height: 26,),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text('Follow up With: ',style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                    SizedBox(width: 10,),
                                    Text('Rotex',style: TextStyle(
                                        color: Colors.black,fontWeight: FontWeight.w600
                                    ),)
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children: const [
                                    Text('Prospect: ',style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                    Text('Rotex bangladesh Ltd',style: TextStyle(
                                        color: Colors.black,fontWeight: FontWeight.w600
                                    ),)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Text('8m ago',style: TextStyle(
                            color: primaryColor
                        ),)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset('images/checklist.png',height: 26,),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text('Follow up With: ',style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                    Text('Executive',
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.black,fontWeight: FontWeight.w600
                                      ),)
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children: const [
                                    Text('Prospect: ',style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                    Text('Rotex bangladesh Ltd',style: TextStyle(
                                        color: Colors.black,fontWeight: FontWeight.w600
                                    ),)
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children: const [
                                    Text('Lead: ',style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                    Text('SaleBee CRM',style: TextStyle(
                                        color: Colors.black,fontWeight: FontWeight.w600
                                    ),)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Text('8m ago',style: TextStyle(
                            color: primaryColor
                        ),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
