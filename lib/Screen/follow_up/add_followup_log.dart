import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Model/getListForTaskModel.dart';
import 'package:salebee/Screen/Prospect/prspect_front_tab.dart';
import 'package:salebee/Screen/expense/expense_create/food.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/transport_claimed/transport_expense_list.dart';
import 'package:salebee/Screen/follow_up/follow_up_page.dart';
import 'package:salebee/Screen/follow_up/followup_controller.dart';
import 'package:salebee/Screen/task/add_new_task.dart';
import 'package:salebee/Screen/task/add_task_form.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/expense_repository.dart';
import 'package:salebee/repository/followup_repository.dart';
import 'package:salebee/utils.dart';

class AddLogFollowUp extends StatefulWidget {
  int? prospectID;
  String? prospect;
  AddLogFollowUp({Key? key, this.prospectID , this.prospect}) : super(key: key);

  @override
  State<AddLogFollowUp> createState() =>
      _TransportExpenseCreatePageState();
}

class _TransportExpenseCreatePageState
    extends State<AddLogFollowUp> {
  final selectedDate = DateTime.now().obs;
  TaskRepository taskRepository = TaskRepository();
  FollowUpRepository followUpRepository = FollowUpRepository();
  final pickedDate = ''.obs;
  FollowUpController followUpController = FollowUpController();
  List<String> allList = [];
  var wayDescriptionController = TextEditingController();
  var vehicleNameController = TextEditingController();
  var vehicleNumController = TextEditingController();
  var startLocationController = TextEditingController();
  var personController = TextEditingController();
  var costController = TextEditingController();
  var endLocationController = TextEditingController();
  var pricingController = TextEditingController();
  int wayTypeIndex = 0;
  int outcomeTypeIndex = 0;
  String? newProspect = "Select";
  int wayType = 0;
  int outcomeType = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  List<String> way = [
    "Other",
    'Call',

    'Email',
    'Meeting',
    'Visit',

  ];
  List<String> outcome = [
  "Connected",
  "Could not reach",
  "Number Busy",
  "Number Switched off",
  ];

  var bytes;
  bool circular = false;
  String? newEmployee;


  @override
  void initState() {
    // TODO: implement initState

    taskRepository.getAllListForTaskController().then((value) {
      if (value.result == null) {
        print("some error++");
      } else {
        newProspect = value.result!["SelectListProspects"]![0].text;
      }

      //prospectList = value.result!["SelectListProspects"]!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Log- ${widget.prospect}"),

      ),
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
                    'Log Activity',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 90,
                            childAspectRatio: 6 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: way.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                wayTypeIndex = index;
                                wayType = wayTypeIndex;
                                //cat = incomeList[index];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: wayTypeIndex == index
                                    ? Colors.orangeAccent[100]
                                    : primaryColorSecond,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          way[index],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: wayTypeIndex == index
                                                ? Colors.white
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
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
                  wayTypeIndex == 1 ?
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Outcome Type',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 100,
                          child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 6 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              itemCount: outcome.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      outcomeTypeIndex = index;
                                      outcomeType = outcomeTypeIndex;
                                      //cat = incomeList[index];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: outcomeTypeIndex == index
                                          ? Colors.orangeAccent[100]
                                          : primaryColorSecond,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                outcome[index],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: wayTypeIndex == index
                                                      ? Colors.white
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ) : Container(),


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
                      maxLines: 3,
                      controller: wayDescriptionController,
                      onChanged: (value) {
                        // _productController.searchProduct(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefix: Container(
                          width: 20,
                        ),
                        hintText: 'Type Details',
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
                  widget.prospectID == null ?
                  Container(
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Related With (Prospect/Client)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<GetListForTaskDataModel>(
                            future: taskRepository.getAllListForTaskController(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              } else {
                                snapshot.data!.result!["SelectListProspects"]!
                                    .forEach((element) {
                                  allList.add(element.text);
                                });
                              }
                              if (snapshot.hasError) {
                                return Container();
                              } else if (snapshot.data != null) {
                                return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                        Border.all(color: borderColor, width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownSearch<String>(
                                          popupProps: PopupProps.menu(
                                            fit: FlexFit.loose,
                                            showSearchBox: true,
                                            showSelectedItems: true,
                                            disabledItemFn: (String s) =>
                                                s.startsWith('I'),
                                          ),
                                          items: allList,
                                          dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                            dropdownSearchDecoration: InputDecoration(
                                              hintText: "Employee List",
                                            ),
                                          ),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            print('taxGroup $value');

                                            setState(() {
                                              newProspect = value;
                                              snapshot.data!
                                                  .result!["SelectListProspects"]!
                                                  .forEach((element) {
                                                // print("${element.text}"+"$newLead");
                                                if (element.text == newProspect) {
                                                  StaticData.prospectID =
                                                      int.parse(element.value);
                                                  print(
                                                      "my assign id is ${StaticData.prospectID}");
                                                } else {
                                                  // _showSnack("Task Assign to ${StaticData.assignToID}");
                                                  // print("no match in assign to");
                                                }
                                              });
                                            });
                                          },
                                          selectedItem: allList[0],
                                        ),
                                      ),
                                    ));
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ],
                    ),
                  ) : Container(),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width:230,
                    child: CheckboxListTile(
                      value: followUpController.checkBox.value,
                      controlAffinity: ListTileControlAffinity.leading, //checkbox at left
                      onChanged: (bool? value) {
                        setState(() {
                          followUpController.checkBox.value = value!;
                        });
                      },
                      title: Text("Next Followup",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold ),),
                    ),
                  ),
                  followUpController.checkBox.value == true ?
                  Container(
                    height: MediaQuery.of(context).size.height * .7,
                    child: AddTaskForm(followUp: true,)
                  ) : Container()


                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: ()  {
                      setState(() {
                        circular = true;
                      });
                      if(followUpController.checkBox.value == true){
                        print("task add started from follwup");
                        taskRepository
                            .taskAddController(
                            token: "token",
                            title: "Log activity",
                            description: wayDescriptionController.text,
                            type: wayTypeIndex,
                            repeat: 0,
                            priority: StaticData.priorityID,
                            status: 0,
                            leadID: StaticData.leadID,
                            assignaTo: StaticData.assignToID)
                            .then((value) {
                          if (value.isSuccess == true) {
                            _showSnack(value.message!);
                            _showSnack("Task Assign to $newEmployee");
                            setState(() {
                              circular = false;
                            });
                            // Get.to(OtherExpense());
                          } else {
                            _showSnack(value.message!);
                            setState(() {
                              circular = false;
                            });
                          }
                        });
                      }
                     followUpRepository.addFollowUpLog(description: wayDescriptionController.text, logType: wayTypeIndex, outComeType: outcomeType, prospectId: widget.prospectID, ).then((e) {
                       print("hlw mir ${e["IsSuccess"]}");

                       if (e["IsSuccess"] == true) {
                         setState(() {
                           circular = false;
                         });
                         Get.to(FollowUpPage(prosId: widget.prospectID, prospect: widget.prospect,));
                         final snackBar = SnackBar(
                           content:  Text(
                               'Activity Successfully added for ${widget.prospect!}'),
                           action: SnackBarAction(
                             label: 'Undo',

                             onPressed: () {
                               // Some code to undo the change.
                             },
                           ),
                         );

                       } else {
                         setState(() {
                           circular = false;
                         });
                       }
                     });

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
  void _showSnack(String msg) {
    final _snackBarContent = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(_scaffoldkey.currentState!.context)
        .showSnackBar(_snackBarContent);
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
