import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/repository/add_task_repository.dart';

class TaskController extends GetxController {
  TaskRepository taskRepository = TaskRepository();
  RxInt totalDayTasks = 0.obs;
  var initiatedList = [].obs;
  @override
  void onInit() {
    super.onInit();
    mytaskMethod(DateTime.now());
    // getOperatorList();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  mytaskMethod(DateTime date){
    print("hlw getx");
    taskRepository.getMyTaskController().then((e){

        initiatedList.value = e.result!.where((element) => element.dueDate!.month == date.month, ).toList();
        totalDayTasks.value = initiatedList.value.length;


    });
  }

}