import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Screen/expense/claimed.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/food_claimed/food_expense_list.dart';
import 'package:salebee/utils.dart';

import '../../../repository/expense_repository.dart';

class FoodExpense extends StatefulWidget {
  FoodExpense({Key? key}) : super(key: key);

  @override
  State<FoodExpense> createState() => _FoodExpenseState();
}

class _FoodExpenseState extends State<FoodExpense> {
  final selectedDate = DateTime.now().obs;
  List<String> type = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
  final pickedDate = ''.obs;
  ExpenseRepository expenseRepository = ExpenseRepository();
  File? file;
  var dishNameController = TextEditingController();
  var pricingController = TextEditingController();
  var textExpenseController = TextEditingController();
  var textDesController = TextEditingController();
  int mealType = 0;
  int foodTypeIndex = 0 ;
   var bytes;
  bool circular = false;
  DateTime todayIs =DateTime.now();

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
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Meal Type',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    child: GridView.builder(
                        gridDelegate:
                        SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 6 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: type.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                foodTypeIndex = index;
                                mealType = foodTypeIndex;
                                //cat = incomeList[index];
                              });
                            },
                            child:  Container(

                              decoration:
                              BoxDecoration(
                                color: foodTypeIndex == index ? Colors.orangeAccent[100] : primaryColorSecond,
                                borderRadius: const BorderRadius
                                    .only(
                                    topLeft: Radius
                                        .circular(
                                        30),
                                    topRight: Radius
                                        .circular(
                                        30),
                                    bottomLeft: Radius
                                        .circular(
                                        30),
                                    bottomRight: Radius
                                        .circular(
                                        30)),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                    horizontal:
                                    8.0,
                                    vertical:
                                    3),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [

                                    Text(
                                      type[index],
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(

                                        fontSize: 12,
                                        color:foodTypeIndex == index ? Colors.white :Colors.white,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),


                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Person',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: TextFormField(
                      onChanged: (value) {
                        // _productController.searchProduct(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),

                        hintText: 'Number of Person',
                        // icon:

                        hintStyle: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Roboto',
                            color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Fooding Expense',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
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

                        hintStyle: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Roboto',
                            color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Description (If Required)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                    child: TextFormField(
                      onChanged: (value) {
                        // _productController.searchProduct(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),

                        hintText: 'Type the dish name',
                        // icon:

                        hintStyle: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Roboto',
                            color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Date',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
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
                                  style: const TextStyle(color: Colors.grey),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Photos(Optional)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _getFromCamera().then((e) {
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text('Tap to Upload')
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
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () async {
                      if(file == null){
                        bytes = null ;
                      } else {
                        bytes = await file!.readAsBytes();
                      }


                      // Get.to(OtherExpense());
                      setState(() {
                        circular = true;
                      });
                      print("working 01");
                      if (pricingController.text == null) {
                        print("working 02");
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
                          setState(() {
                            circular == false;
                          });
                          expenseRepository
                              .foodExpenseController(
                            image: bytes,   mealType: mealType ,
                            dishName: dishNameController.text,
                            expense: int.parse(pricingController.text),
                            date:todayIs.toString(), )
                              .then((e) {
                            print(
                                "my response for other expense is ${e["IsSuccess"]}");
                            if (e["IsSuccess"] == true) {
                              setState(() {
                                circular = false;
                              });
                              final snackBar = SnackBar(
                                content: const Text('Food Expense Successfully added'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FoodClaimedList(),
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
                      child:  Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: circular == true
                          ? CircularProgressIndicator()
                          :Text(
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
