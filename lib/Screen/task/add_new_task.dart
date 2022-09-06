import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/utils.dart';

class AddNewTask extends StatelessWidget {

  final selectedDate = DateTime.now().obs;
  final pickedDate = ''.obs;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title:  Text('Add New Task',style: TextStyle(
            color: appBarHeader,fontSize: 24
        ),),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          color: Colors.grey.shade200,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 70),
                child: ListView(
                  children: [
                    Text('Task Title',style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400,color: text
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: borderColor, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          hintText: 'Enter a task title',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 12.0, fontFamily: 'Roboto',color: tabBarUnSelectedColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Description/Remarks',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        maxLines: 7,
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          hintText: 'Enter a task description',
                          // icon:
                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Type',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Select the type of task',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Priority',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Select the priority level of task',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    const Text('Start',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: Colors.grey, width: 1.5),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration:   InputDecoration(
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Location',
                                suffixIcon: Icon(Icons.location_on_outlined),

                                hintStyle:
                                TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: Colors.grey, width: 1.5),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration:   InputDecoration(
                                suffixIcon: Icon(Icons.access_time),
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Enter Time',
                                // icon:

                                hintStyle:
                                TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    const Text('Due',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: Colors.grey, width: 1.5),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration:   InputDecoration(
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Location',
                                suffixIcon: Icon(Icons.location_on_outlined),

                                hintStyle:
                                TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: Colors.grey, width: 1.5),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              onChanged: (value) {
                                // _productController.searchProduct(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration:   InputDecoration(
                                suffixIcon: Icon(Icons.access_time),
                                prefix: Container(
                                  width: 20,
                                ),
                                hintText: 'Enter Time',
                                // icon:

                                hintStyle:
                                TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(height: 10,),
                    Text('Reminder',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'No Reminder',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Text('Repeat',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'No Repeat',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Text('Prospect',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Select Prospect',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Text('Contact Person',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Select Prospect contact',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Text('Lead',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Select Lead',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Text('Assign to',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Who will be responsible',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Text('Visible to',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Who can see',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Text('Status',style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: TextFormField(
                        onChanged: (value) {
                          // _productController.searchProduct(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration:   InputDecoration(
                          prefix: Container(
                            width: 20,
                          ),
                          suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                          hintText: 'Select Status',
                          // icon:

                          hintStyle:
                          TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: (){
                      // Get.to(OtherExpense());
                    },
                    child: Container(
                      height: 48,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: darkBlue
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('Create',textAlign:TextAlign.center,style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      pickedDate.value = DateFormat.yMMMd().format(picked);
    }
  }
}
