import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/other_claimed/others_expense_list.dart';
import 'package:salebee/utils.dart';
import '../../../repository/expense_repository.dart';
import 'transport.dart';

class OtherExpenseCreate extends StatefulWidget {
  @override
  State<OtherExpenseCreate> createState() => _OtherExpenseState();
}

class _OtherExpenseState extends State<OtherExpenseCreate> {
  final selectedDate = DateTime.now().obs;
  //final ImagePicker _picker = ImagePicker();
  ExpenseRepository expenseRepository = ExpenseRepository();
  var expenseNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var pricingController = TextEditingController();
  var personController = TextEditingController();
  final pickedDate = ''.obs;
  File? file;
  var bytes;
  bool circular = false;
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      file = imageFile;
    }
    return file;
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      file = imageFile;
    }
    return file;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Expense Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: TextFormField(
                  controller: expenseNameController,
                  onChanged: (value) {
                    // _productController.searchProduct(value);
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefix: Container(
                      width: 20,
                    ),
                    hintText: 'Type the Name of Expense',
                    // icon:

                    hintStyle: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                        color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Description/Remarks',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  onChanged: (value) {
                    // _productController.searchProduct(value);
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefix: Container(
                      width: 20,
                    ),
                    hintText: 'Type a Short Note',
                    // icon:
                    hintStyle: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                        color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Person',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: TextFormField(
                  controller: personController,
                  onChanged: (value) {
                    // _productController.searchProduct(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefix: Container(
                      width: 20,
                    ),
                    hintText: 'Number of person',
                    // icon:

                    hintStyle: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                        color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Expense',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: TextFormField(
                  controller: pricingController,
                  onChanged: (value) {
                    // _productController.searchProduct(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefix: Container(
                      width: 20,
                    ),
                    hintText: 'Enter the Amount',
                    // icon:

                    hintStyle: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                        color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text(
                              DateFormat.yMMMd().format(selectedDate.value),
                              style: TextStyle(color: Colors.grey),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Photos(Optional)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _getFromGallery().then((e) {
                          if (e != null) {
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: Colors.grey.withOpacity(.35))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Tap to Upload')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: file == null
                        ? Container()
                        : Image.file(
                            file!,
                            height: 45.0,
                            width: 45.0,
                          ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () async {
                      if (file == null) {
                        bytes = null;
                      } else {
                        bytes = await file!.readAsBytes();
                      }

                      // Get.to(OtherExpense());
                      setState(() {
                        circular = true;
                      });

                      if (expenseNameController.text.isEmpty) {
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
                              .othersExpenseController(
                                  image: bytes,
                                  person: int.parse(personController.text),
                                  expenseName: expenseNameController.text,
                                  discription: descriptionController.text,
                                  expense: int.parse(pricingController.text),
                                  date: selectedDate.toString())
                              .then((e) {
                            print(
                                "my response for other expense is ${e["IsSuccess"]}");
                            if (e["IsSuccess"] == true) {
                              setState(() {
                                circular = false;
                              });
                              final snackBar = SnackBar(
                                content: const Text(
                                    'Other Expense Successfully added'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OtherClaimedList(),
                                ),
                              );
                            } else {
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
                          color: darkBlue),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: circular == true
                              ? CircularProgressIndicator()
                              : Text(
                                  'Submit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
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
