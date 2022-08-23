import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/utils.dart';

class Applied extends StatelessWidget {
  const Applied({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('5 Jul - 7 Jul | 2022',style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                            ),),
                            SizedBox(height: 10,),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text('3 days |',style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                )),
                                SizedBox(width: 5,),
                                Text('Pending',style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                                ),)
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.arrow_forward_ios_outlined))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('20 Mar - 27 Mar | 2022',style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                            SizedBox(height: 10,),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text('3 days |',style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                )),
                                SizedBox(width: 5,),
                                Text('Not Granted',style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),)
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.arrow_forward_ios_outlined))
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
