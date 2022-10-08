import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/utils.dart';

import 'leave_request.dart';

class Granted extends StatelessWidget {
  const Granted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 58 ,
        color: const Color(0xFFE5E5E5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: (){
              Get.to(const LeaveRequest());
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: darkBlue
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Apply leave request',
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
        color: const Color(0xFFE5E5E5),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('images/leave_granted.png'),
                  Text('No Leave',style: TextStyle(
                    color: darkBlue,
                    fontSize: 18
                  ),),
                  const SizedBox(height: 10,),
                  const Text('Eureka! Keep your enthusiasm.',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
