import 'package:flutter/material.dart';
import 'package:salebee/utils.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title:  Text('Notification',style: TextStyle(
            color: appBarHeader,fontSize: 24
        ),),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
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
                child: Icon(Icons.person,color: primaryColor,),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Expanded(
                       child: Container(),
                     ),
                     Expanded(
                       child: Container(
                         width: 100,
                         decoration: BoxDecoration(
                           color: darkBlue,
                           borderRadius: BorderRadius.circular(6)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Center(
                             child: Text('Yesterday',style: TextStyle(
                              color: Colors.white,fontSize: 12
                ),),),
                         ),
                       ),
                     ),
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Center(
                           child: Text('Mark as read',style: TextStyle(
                               color: primaryColor,fontSize: 12
                           ),),),
                       ),
                     )
                   ],
                 ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColorLight,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                                  child: Image.asset('images/checklist.png',height: 20,),
                                ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children:  [
                                    Text('Follow up With: ',style: TextStyle(
                                      color: Colors.grey,fontSize: 12
                                    ),),
                                    SizedBox(width: 10,),
                                    Text('Rotex',style: TextStyle(
                                        color: text,fontWeight: FontWeight.w400,fontSize: 12
                                    ),)
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children:  [
                                    Text('Prospect: ',style: TextStyle(
                                        color: Colors.grey,fontSize: 12
                                    ),),
                                    Text('Rotex bangladesh Ltd',style: TextStyle(
                                        color: text,fontWeight: FontWeight.w400,fontSize: 12
                                    ),)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Text('8m ago',style: TextStyle(
                          color: primaryColor,fontSize: 12
                        ),)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      color: primaryColorLight,
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
                                child: Image.asset('images/checklist.png',height: 20,),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Follow up With: ',style: TextStyle(
                                        color: Colors.grey,fontSize: 12
                                    ),),
                                    Text('Executive',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: text,fontWeight: FontWeight.w400,fontSize: 12
                                    ),)
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children:  [
                                    Text('Prospect: ',style: TextStyle(
                                        color: Colors.grey,fontSize: 12
                                    ),),
                                    Text('Rotex bangladesh Ltd',style: TextStyle(
                                        color: text,fontWeight: FontWeight.w400,fontSize: 12
                                    ),)
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text('Lead: ',style: TextStyle(
                                        color: Colors.grey,fontSize: 12
                                    ),),
                                    Text('SaleBee CRM',style: TextStyle(
                                        color: text,fontWeight: FontWeight.w400,fontSize: 12
                                    ),)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Text('8m ago',style: TextStyle(
                            color: primaryColor,fontSize: 12
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
