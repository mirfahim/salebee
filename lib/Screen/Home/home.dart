import 'package:flutter/material.dart';

import '../../utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /12), (size.height /24), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /12), (size.height /24), 0.0),
                              child: const Text('Option E',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /2.5), (size.height /8), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /2.5), (size.height /8), 0.0),
                              child: const Text('Option D',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /1.9), (size.height /3.3), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /1.9), (size.height /3.3), 0.0),
                              child: const Text('Option C',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /2.5), (size.height /2), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /2.5), (size.height /2), 0.0),
                              child: const Text('Option D',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /12), (size.height /1.7), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /12), (size.height /1.7), 0.0),
                              child: const Text('Option A',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
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
                    Row(
                      children: [
                        Icon(Icons.arrow_forward,color: darkBlue,),
                        Text('Next',style: TextStyle(
                            color: darkBlue
                        ),)
                      ],
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
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /12), (size.height /15), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /12), (size.height /15), 0.0),
                              child: const Text('Option E',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /2.7), (size.height /8), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /2.7), (size.height /8), 0.0),
                              child: const Text('Option D',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /1.9), (size.height /3.3), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /1.9), (size.height /3.3), 0.0),
                              child: const Text('Option C',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /2.5), (size.height /2), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /2.5), (size.height /2), 0.0),
                              child: const Text('Option D',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor
                            ),
                            transform: Matrix4.translationValues((size.width /12), (size.height /1.74), 0.0),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.ac_unit,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                              transform: Matrix4.translationValues((size.width /12), (size.height /1.74), 0.0),
                              child: const Text('Option A',style: TextStyle(
                                  color: Colors.grey
                              ),)
                          )
                        ],
                      ),
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
                    Row(
                      children: [
                        Icon(Icons.arrow_forward,color: darkBlue,),
                        Text('Next',style: TextStyle(
                            color: darkBlue
                        ),)
                      ],
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
