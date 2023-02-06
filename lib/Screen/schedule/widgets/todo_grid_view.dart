import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Model/getAllMyTaskModel.dart';
import 'package:salebee/Screen/schedule/widgets/todo_tile.dart';
import 'package:salebee/Screen/task/task_controller/task_controller.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/repository/add_task_repository.dart';


class TodoGridView extends StatefulWidget {
  List<String> todoList;
  TodoGridView({Key? key, required this.todoList}) : super(key: key);

  @override
  _TodoGridViewState createState() => _TodoGridViewState();
}

class _TodoGridViewState extends State<TodoGridView> {
TaskController taskController = TaskController();
TaskRepository taskRepository = TaskRepository();
  @override
  Widget build(BuildContext context) {
    return Column(

      children:  [
        InkWell(
          onTap: (){
            Get.to(Task());
          },
          child: Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Official Tasks"),
                    FutureBuilder<GetAllMyTaskModel>(
                      future: taskRepository.getMyTaskController(),
                      builder: (BuildContext context,
                          AsyncSnapshot<GetAllMyTaskModel> snapshot) {
                        if (snapshot.data == null) {
                          print("no data found");
                        } else {}

                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text("waiting");
                          default:
                            if (snapshot.hasError)
                              return Center(child: Text('No Data Found'));
                            if (snapshot.data == null) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Container(
                                child: Text(snapshot.data!.result!.where((element) => element.statusId == 5 && element.dueDate!.month == DateTime.now().month
                                    && element.dueDate!.year == DateTime.now().year
                                    && element.dueDate!.day == DateTime.now().day ).toList().length.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),),
                              );
                            }
                        }
                      },
                    ),


                  ],
                )),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height -250,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: widget.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: (){
                    print("tapped");
                    Add2Calendar.addEvent2Cal(
                      buildEvent(title:  widget.todoList[index].split(",")[1], description: widget.todoList[index].split(",")[2]),
                    );
                  },
                  child: TodoTile(title: widget.todoList[index].split(",")[1], description: widget.todoList[index].split(",")[2]));
            },
          ),
        ),
      ]
    );
  }
  Event buildEvent({Recurrence? recurrence, String? title, String? description }) {
    return Event(
      title: title!,
      description: description!,
      location: 'Flutter app',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 40),
        url: "http://example.com",
      ),
      androidParams: const AndroidParams(
        emailInvites: ["kamal.gmap.api1@gmail.com", "mirfahim390@gmail.com"],
      ),
      recurrence: recurrence,
    );
  }
}