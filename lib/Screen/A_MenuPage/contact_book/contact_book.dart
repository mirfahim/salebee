import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

import 'package:get/get.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Screen/A_MenuPage/contact_book/contact_controller.dart';
import 'package:salebee/Utils/custom_date.dart';
import 'package:salebee/Utils/get_ui.dart';


class MobileRechargeView extends GetView<MobileRechargeController> {

  const MobileRechargeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Obx(() {
          if (controller.contactLoaded.isTrue) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: Container(
                width: size.width,
                decoration: Ui.getBoxDecoration(
                  color: Get.theme.cardColor,
                  radius: 5,
                  shadowColor: Get.theme.primaryColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Contacts',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Get.theme.disabledColor.withOpacity(0.6),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          child: TextField(
                            onChanged: (e) {

                              controller.searchString.value = e;
                              controller.contactsResult.value = _search(controller.contacts.value);

                            },
                            controller: controller.searchController,
                            decoration: InputDecoration(
                                labelText: "Search",
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.width * .04,
                      ),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(controller.alphabetFoundList.length, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.width * .04,
                              ),
                              Container(
                                height: size.width * .07,
                                width: size.width * .07,
                                decoration: Ui.getBoxDecoration(
                                  color: Get.theme.primaryColor,
                                  radius: 5,
                                  shadowColor: Get.theme.primaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Center(
                                    child: Text(
                                      controller.alphabetFoundList[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: List.generate(controller.contactsResult.value.length, (index2) {
                                  var data = controller.contactsResult[index2];
                                  return data.displayName[0].toUpperCase() == controller.alphabetFoundList[index]
                                      ? Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
                                    child: ListTile(
                                      onTap: () {
                                        print("mobile recharge presssed");

                                        StaticData.mobileNo = data.phones.first.normalizedNumber;
                                        controller.textEditingController.text = data.phones.first.normalizedNumber;
                                        controller.mobileNumber.value = StaticData.mobileNo!;
                                        controller.name.value = data.displayName;

                                        print("123123${controller.mobileNumber.value}");

                                      },
                                      leading: Image.asset(
                                        'images/Icons/contact.png',
                                        color: Get.theme.primaryColor,
                                      ),
                                      title: Text(
                                        data.displayName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Get.theme.textTheme.bodyText1!.color,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '', // controller.contacts[index2].phones.first.normalizedNumber,
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.normal, color: Get.theme.textTheme.bodyText1!.color),
                                      ),
                                    ),
                                  )
                                      : Wrap();
                                }),
                              )
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            )



                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }

  List<Contact> _search(List<Contact>? contactsList) {
    if (controller.searchString.value.isNotEmpty == true || controller.searchString.value != "") {
      //search logic what you want
      return contactsList
          ?.where((element) =>
          element.displayName!.toLowerCase().contains(controller.searchString.value))
          .toList() ??
          <Contact>[];


    }else {
      return controller.contacts.value;
    }


  }
}
