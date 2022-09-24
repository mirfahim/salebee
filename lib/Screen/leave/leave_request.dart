import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/leave/select_subtitute.dart';

import '../../utils.dart';
import 'leave_request_succeed.dart';

class LeaveRequest extends StatelessWidget {
  const LeaveRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      appBar: AppBar(
        backgroundColor: backgroudColor,
        title:  Text('Leave Request',style: TextStyle(
            color: appBarHeader,fontSize: 24
        ),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: backgroudColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Leave Type',style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                  ),),
                  const SizedBox(height: 10,),
                  Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                  Text('Annual',style: TextStyle(
                                      fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                                  ),),
                                Text('17 Days',style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                                ),)
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Sick',style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                                ),),
                                Text('1 Days',style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                                ),)
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Others',style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                                ),),
                                Text('1 Days',style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                                ),)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(''),
                                Text('Remaining: 20 Days',style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF617692)
                      ),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Note*',style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                  ),),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                        Border.all(color: const Color(0xFFD2DDEC), width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                    child: TextFormField(
                      onChanged: (value) {
                        // _productController.searchProduct(value);
                      },
                      maxLines: 7,
                      keyboardType: TextInputType.text,
                      decoration:   InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),
                        hintText: 'Type a short note',

                        hintStyle:const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF7C8DB5)
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Substitute',style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                  ),),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                        Border.all(color: const Color(0xFFD2DDEC), width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                    child: TextFormField(
                      onChanged: (value) {
                        // _productController.searchProduct(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration:   InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),
                        hintText: 'Add a Substitute',
                        suffixIcon: InkWell(
                          onTap: (){
                            Get.to(SelectSubtitute());
                          },
                            child: Icon(Icons.add,color: primaryColor,)),
                        hintStyle:
                        const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF7C8DB5)
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('From',style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                            ),),
                            const SizedBox(height: 5,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: const Color(0xFFD2DDEC), width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                              child: TextFormField(
                                onChanged: (value) {
                                  // _productController.searchProduct(value);
                                },
                                keyboardType: TextInputType.text,
                                decoration:   InputDecoration(
                                  prefix: Container(
                                    width: 20,
                                  ),
                                  hintText: 'Pick a date',
                                  suffixIcon: Icon(Icons.calendar_today,color: primaryColor,size: 16,),
                                  hintStyle:
                                  const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF7C8DB5)
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('To',style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                            ),),
                            const SizedBox(height: 5,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: const Color(0xFFD2DDEC), width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                              child: TextFormField(
                                onChanged: (value) {
                                  // _productController.searchProduct(value);
                                },
                                keyboardType: TextInputType.text,
                                decoration:   InputDecoration(
                                  prefix: Container(
                                    width: 20,
                                  ),
                                  hintText: 'Pick a date',
                                  suffixIcon: Icon(Icons.calendar_today,color: primaryColor,size: 16,),
                                  hintStyle:
                                  const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF7C8DB5)
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text('*0 days',style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                  ),),
                  const SizedBox(height: 10,),
                  const Divider(thickness: 1, color: Color(0xFFD2DDEC),),
                  const SizedBox(height: 10,),
                  const Text('Photos(Optional)',style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                  ),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor.withOpacity(.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey.withOpacity(.35))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt,color: primaryColor,),
                                const SizedBox(width: 10,),
                                const Text('Tap to Upload',style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0C162C)
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 58 ,
          color: const Color(0xFFE5E5E5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: (){
                Get.to(const LeaveRequestSucceed());
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: darkBlue
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Submit request',
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
      ),
    );
  }
}
