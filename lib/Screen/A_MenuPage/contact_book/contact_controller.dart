import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';


class MobileRechargeController extends GetxController {
  //TODO: Implement MobileRechargeController
  List<String> way = ['10', '20', '30', '40', '50', '60', '70', '80'].obs;
  var data = "".obs;
  RxBool customWidget = false.obs;
  TextEditingController textEditingController = TextEditingController();
  RxDouble value = 0.0.obs;
  final searchString = "".obs;
  final contacts = <Contact>[].obs;
  final contactsResult = <Contact>[].obs;
  final contactLoaded = false.obs;
  final colorChange = "".obs;
  RxBool operatorSelect = false.obs;
  TextEditingController searchController = TextEditingController();
  final alphabetList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ].obs;
  final operatorCode = "".obs;
  final mobileNumber = ''.obs;
  final amount = 0.0.obs;
  final name = ''.obs;

  final success = false.obs;
  final alphabetFoundList = [].obs;
  final bankLoaded = false.obs;
  @override
  void onInit() {
    super.onInit();
    getContacts();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  getContacts() async {
    print("my contact start");
    try {
      // Request contact permission
      if (await FlutterContacts.requestPermission()) {
        // Get all contacts (lightly fetched)
        // contacts.value = await FlutterContacts.getContacts();

        // Get all contacts (fully fetched)
        contacts.value = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);

        // Get contact with specific ID (fully fetched)
        //  Contact? contact = await FlutterContacts.getContact(contacts.first.id);

        print('MobileRechargeController.getContacts: ${contacts.first.phones}');

        await addAlphabet();
        // print('MobileRechargeController.alphabet: ${alphabetFoundList[0].contacts!.length}');

        contactLoaded.value = true;
        contactsResult.value = contacts.value;
      }
    } catch (e) {
      print("my contact erros is $e");
      rethrow;
    }
  }
  // 'phone_number': "01782084390",
  // 'amount': "10",
  // 'operator': "RR",
  // "recharge_type": "pre-paid"


  addAlphabet() {
    for (int index = 0; index < alphabetList.length; index++) {
      for (var item in contacts) {
        //  print(item);
        if (item.displayName[0].toUpperCase() == alphabetList[index]) {
          alphabetFoundList.add(alphabetList[index]);
          break;
        }
      }
    }
  }
}
