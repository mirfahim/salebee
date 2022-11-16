import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/expense/expense_create/food.dart';
import 'package:salebee/repository/expense_repository.dart';
import 'package:salebee/utils.dart';

class TransportExpenseCreatePage extends StatefulWidget {
  TransportExpenseCreatePage({Key? key}) : super(key: key);

  @override
  State<TransportExpenseCreatePage> createState() => _TransportExpenseCreatePageState();
}

class _TransportExpenseCreatePageState extends State<TransportExpenseCreatePage> {
  final selectedDate = DateTime.now().obs;
  ExpenseRepository expenseRepository = ExpenseRepository();
  final pickedDate = ''.obs;
  var textExpenseController = TextEditingController();
  var textDesController = TextEditingController();
  File? file;

  bool circular = false ;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      file = imageFile ;
    }
    return file ;
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      file = imageFile ;
    }
    return file ;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(height: 10,),
                  const Text('Way',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 10,),
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
                        suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
                        hintText: 'Air',
                        // icon:

                        hintStyle:
                        const TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Vehical Name',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                        Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                    child: TextFormField(
                      controller: textExpenseController,
                      onChanged: (value) {
                        // _productController.searchProduct(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration:   InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),
                        hintText: 'Type athe vehical name',
                        suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
                        hintStyle:
                        const TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Vehical Number(Optional)',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 10,),
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
                        hintText: 'Enter the vehicle Number',

                        hintStyle:
                        const TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Pricing',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 10,),
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
                      keyboardType: TextInputType.number,
                      decoration:   InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),
                        hintText: 'Enter the Amount',
                        // icon:

                        hintStyle:
                        const TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Date',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      _selectDate(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>Text(DateFormat.yMMMd().format(selectedDate.value),style: const TextStyle(
                                color: Colors.grey
                            ),)),
                            const SizedBox(width: 10,),
                            const Icon(Icons.calendar_today,size: 14,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
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
                              suffixIcon: const Icon(Icons.location_on_outlined),

                              hintStyle:
                              const TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
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
                              suffixIcon: const Icon(Icons.access_time),
                              prefix: Container(
                                width: 20,
                              ),
                              hintText: 'Enter Time',
                              // icon:

                              hintStyle:
                              const TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
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
                              suffixIcon: const Icon(Icons.location_on_outlined),

                              hintStyle:
                              const TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
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
                              suffixIcon: const Icon(Icons.access_time),
                              prefix: Container(
                                width: 20,
                              ),
                              hintText: 'Enter Time',
                              // icon:

                              hintStyle:
                              const TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 10,),
                  const Text('Photos(Optional)',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            _getFromGallery().then((e){
                              if(e != null){
                                setState(() {

                                });
                              }

                            });
                          },
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
                                  const Text('Tap to Upload')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: file == null ?
                        Container()
                            :Image.file(
                          file!,
                          height: 45.0,
                          width: 45.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 100,),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: ()async{
                      var bytes = await file!.readAsBytes();
                      print("my image file is ${file!.path}");
                      // Get.to(OtherExpense());
                      setState(() {
                        circular = true;
                      });

                      if (textExpenseController.text.isEmpty) {
                        final snackBar = SnackBar(
                          content: const Text('Please fill all the form field'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          circular == false;
                        });

                      } else {
                        try {
                          File file = File("");
                          expenseRepository
                              .transportExpenseController(bytes)
                              .then((e) {
                            print("my response for other expense is ${e["IsSuccess"]}");
                            if(e["IsSuccess"] == true){
                              setState(() {
                                circular = false;
                              });
                            }else {
                              setState(() {
                                circular = false;
                              });
                            }
                            setState(() {
                              circular = false;
                            });
                          });
                        } catch (e) {
                          setState(() {
                            circular = false;
                          });
                        }
                      }
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
                          child: Text('Submit',textAlign:TextAlign.center,style: TextStyle(
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
