import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/utils.dart';

class LeaveRequestSucceed extends StatelessWidget {
  const LeaveRequestSucceed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: primaryColorLight.withOpacity(.6),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text('Leave Request Sent successfully'
                    'Please wait for the approval',textAlign: TextAlign.center,style: TextStyle(
                  color: darkBlue
                ),),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(child: InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.blue
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Go to Home',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white
                            ),),
                        ),
                      ),
                    )),
                    Expanded(child: InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          border: Border.all(
                            color: Colors.grey
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('View Details',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: darkGreen
                            ),),
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
