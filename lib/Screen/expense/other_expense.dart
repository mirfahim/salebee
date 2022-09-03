import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/utils.dart';
import '../../repository/expense_repository.dart';
import 'transport.dart';
class OtherExpense extends StatefulWidget {
   OtherExpense({Key? key}) : super(key: key);

  @override
  State<OtherExpense> createState() => _OtherExpenseState();
}

class _OtherExpenseState extends State<OtherExpense> {
  final selectedDate = DateTime.now().obs;
  ExpenseRepository expenseRepository = ExpenseRepository();
  var textExpenseController = TextEditingController();
  var textDesController = TextEditingController();
  final pickedDate = ''.obs;

  bool circular = false ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense',style: TextStyle(
            color: Colors.black,fontWeight: FontWeight.w600
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
        actions: [
          InkWell(
            onTap: (){
              Get.to(TransportPage());
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150),
              ),
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.person,color: darkBlue,),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              ListView(
                children: [
                  Text('Expense Name',style: TextStyle(
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
                      controller: textExpenseController,
                      onChanged: (value) {
                        // _productController.searchProduct(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration:   InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),
                        hintText: 'Type the Name of Expense',
                        // icon:

                        hintStyle:
                        TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
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
                        hintText: 'Type a Short Note',
                        // icon:
                        hintStyle:
                        TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Pricing',style: TextStyle(
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
                      keyboardType: TextInputType.number,
                      decoration:   InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),
                        hintText: 'Enter the Amount',
                        // icon:

                        hintStyle:
                        TextStyle(fontSize: 14.0, fontFamily: 'Roboto',color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Date',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 10,),
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
                            Obx(()=>Text(DateFormat.yMMMd().format(selectedDate.value),style: TextStyle(
                                color: Colors.grey
                            ),)),
                            const SizedBox(width: 10,),
                            Icon(Icons.calendar_today,size: 14,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Divider(thickness: 1,color: Colors.grey,),
                  SizedBox(height: 10,),
                  Text('Photos(Optional)',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 10,),
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
                                SizedBox(width: 10,),
                                Text('Tap to Upload')
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: (){
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
                          expenseRepository
                              .othersExpenseController()
                              .then((e) {
                            if(e.isSuccess == true){
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
                      child:  Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: circular == true ? CircularProgressIndicator(): Text('Submit',textAlign:TextAlign.center,style: TextStyle(
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
