import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUpController extends GetxController {
  //TODO: Implement BusTicketController

  ///date & time
  final journeyDate = DateTime.now().obs;
  final journeyTime = TimeOfDay.now().obs;
  final checkBox = true.obs;

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: journeyDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      helpText: 'Select Journey Date',
      fieldHintText: 'Month/Date/Year',
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (pickedDate != null && pickedDate != journeyDate.value) {
      journeyDate.value = pickedDate;
    }
  }

  chooseTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: journeyTime.value,
      builder: (context, child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!);
      },
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: 'Select Time',
      errorInvalidText: 'Provide valid time',
      hourLabelText: 'Select Hour',
      minuteLabelText: 'Select Minute',
    );
    if (pickedTime != null && pickedTime != journeyTime.value) {
      journeyTime.value = pickedTime;
    }
  }



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
