

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/utils.dart';

class CheckInOut extends StatelessWidget {
  CheckInOut({Key? key}) : super(key: key);

  final checkIn = false.obs;
  final checkOut = false.obs;
  final circularProgressIndicatorValue = 0.0.obs;
  final end = 0.0.obs;
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50,),
        SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(DateFormat('hh:mm').format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w300
                  ),),
                  const SizedBox(width: 5,),
                  Text(DateFormat('a').format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                    ),),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat.EEEE().format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                  const SizedBox(width: 5,),
                  Text(DateFormat.yMd().format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                ],
              ),
            ],
          ),
        ),
        Obx(()=>TweenAnimationBuilder(
          duration: Duration(seconds: 3),
          tween: Tween(begin: 0.0,end: end.value),
          builder: (context,double value, _){
            circularProgressIndicatorValue.value = value;
            return Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      color: end.value == 1 ? Colors.blue : Colors.amber,
                      value: circularProgressIndicatorValue.value,
                      backgroundColor: Colors.grey,
                      strokeWidth: 5,
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      end.value = 1;
                      // Timer(Duration(seconds: 3), () {
                      //   circularProgressIndicatorValue.value = circularProgressIndicatorValue.value + .1;
                      //   print('pressed for 3 seconds');
                      // });
                    },
                    onLongPressCancel: (){
                      end.value = 0;
                    },
                    child: Obx(()=>Container(
                      height: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: end.value == 1 ? Colors.blue : Colors.amber
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(70.0),
                        child: Image.asset('images/tap.png',height: 40,width: 40,),
                      ),
                    )),
                  ),
                ),
              ],
            );
          },
        )),
        SizedBox(height: 10,),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined),
              SizedBox(width: 10,),
              Text('Central park')
            ],
          ),
        ),
        SizedBox(height: 30,),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.person, color: primaryColor,),
                    const Text('10:26',style: TextStyle(fontWeight: FontWeight.w600),),
                    SizedBox(height: 5,),
                    const Text('Check In',style: TextStyle(color: Colors.grey,fontSize: 12),),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.person_add_alt, color: primaryColor,),
                    const Text('--:--',style: TextStyle(fontWeight: FontWeight.w600),),
                    SizedBox(height: 5,),
                    const Text('Check Out',style: TextStyle(color: Colors.grey,fontSize: 12),),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_circle_right, color: primaryColor,),
                    const Text('08:26',style: TextStyle(fontWeight: FontWeight.w600),),
                    SizedBox(height: 5,),
                    const Text('Working Hour',style: TextStyle(color: Colors.grey,fontSize: 12),),
                  ],
                ),
              ],
            )),

            Expanded(
              child: Container(),
            )
          ],
        )
      ],
    );
  }
}
