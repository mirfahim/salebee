import 'package:flutter/material.dart';

import '../../utils.dart';
import 'package:get/get.dart';

import '../Attendence_report/attendence_report.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget circleRow(size, option,x,y){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor
          ),
          transform: Matrix4.translationValues(x, y, 0.0),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.ac_unit,color: Colors.white,),
          ),
        ),
        SizedBox(width: 5,),
        Container(
            transform: Matrix4.translationValues(x, y, 0.0),
            child:  Text('Option $option',style: const TextStyle(
                color: Colors.grey
            ),)
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
    if(size.height < 650){
      return  Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Rayhan Uddin', style: TextStyle(
                            fontSize: 20, color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: 2,),
                        Text('01502020222', style: TextStyle(
                            fontSize: 16, color: Colors.grey
                        ),)
                      ],
                    ),
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
                          child: Icon(Icons.edit_outlined,color: darkBlue,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: size.height / 1.3,
                        transform: Matrix4.translationValues(-(size.width /2.5), 0.0, 0.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-(size.width /3.8), (size.height /7), 0.0),
                        child: const CircleAvatar(
                          radius: 130,
                          backgroundImage: AssetImage('images/person.jpg',),
                        ),
                      ),
                      circleRow(size,'E',(size.width /12),(size.height /24),
                      ),

                      circleRow(size,'D',(size.width /2.5),(size.height /8)),

                      circleRow(size,'C',(size.width /1.9),(size.height /3.3)),

                      circleRow(size,'B',(size.width /2.5),(size.height /2)),

                      circleRow(size,'A',(size.width /12),(size.height /1.7)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_back,color: darkBlue,),
                        Text('Prev',style: TextStyle(
                            color: darkBlue
                        ),)
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Get.to( AttendenceReport());
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_forward,color: darkBlue,),
                          Text('Next',style: TextStyle(
                              color: darkBlue
                          ),)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }else if(size.height > 700){
      return  Scaffold(
        backgroundColor: primaryColorLight,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Rayhan Uddin', style: TextStyle(
                            fontSize: 20, color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: 2,),
                        Text('01502020222', style: TextStyle(
                            fontSize: 16, color: Colors.grey
                        ),)
                      ],
                    ),
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
                          child: Icon(Icons.edit_outlined,color: darkBlue,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: size.height / 1.3,
                        transform: Matrix4.translationValues(-(size.width /2.5), 0.0, 0.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-(size.width /3.8), (size.height /5.5), 0.0),
                        child: const CircleAvatar(
                          radius: 140,
                          backgroundImage: AssetImage('images/person.jpg',),
                        ),
                      ),
                      circleRow(size, 'E', (size.width /12), (size.height /15)),

                      circleRow(size, 'D', (size.width /2.7), (size.height /8)),
                      circleRow(size, 'C', (size.width /1.9), (size.height /3.3)),

                      circleRow(size, 'B', (size.width /2.5), (size.height /2)),

                      circleRow(size, 'A', (size.width /12), (size.height /1.74)),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_back,color: darkBlue,),
                        Text('Prev',style: TextStyle(
                            color: darkBlue
                        ),)
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Get.to( AttendenceReport());
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_forward,color: darkBlue,),
                          Text('Next',style: TextStyle(
                              color: darkBlue
                          ),)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
