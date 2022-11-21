import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/utils.dart';

class Claimed extends StatelessWidget {
  const Claimed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLight,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('Chose a type of expense',style: TextStyle(
                  color: Colors.grey.withOpacity(.75)
              ),),
              const SizedBox(height: 10,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: primaryColor)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset('images/food.png',height: 70,),
                        const SizedBox(width: 10,),
                        const Text(' Food',style: TextStyle(
                            fontWeight: FontWeight.w500,
                          fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: primaryColor)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset('images/transportation.png',height: 70,),
                        const SizedBox(width: 10,),
                        const Text(' Transport',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: primaryColor)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset('images/more.png',height: 70,),
                        const SizedBox(width: 10,),
                        const Text(' Others',style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
