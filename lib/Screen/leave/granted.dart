import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/utils.dart';

import 'leave_request.dart';

class Granted extends StatelessWidget {
  const Granted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: (){
            Get.to(LeaveRequest());
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: darkBlue
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Apply leave request',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white
                ),),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('No Leave',style: TextStyle(
                  color: darkBlue,
                  fontSize: 18
                ),),
                SizedBox(height: 10,),
                const Text('No Leave',style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
