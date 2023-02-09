import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salebee/Model/employee/employee_list_model.dart';
import 'package:salebee/Screen/A_MenuPage/course/datas/courses_json.dart';
import 'package:salebee/Screen/A_MenuPage/course/widgets/custom_course_card.dart';
import 'package:salebee/repository/attendance_repository.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';



class MarketingPage extends StatefulWidget {
  const MarketingPage({Key? key}) : super(key: key);

  @override
  State<MarketingPage> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<MarketingPage> {
  AttendanceRepository attendanceRepository = AttendanceRepository();
  TextEditingController searchController = TextEditingController();
  bool department = true;
  List<Results> searchEmployeeList = [];
  bool searchStart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("packages"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [

            SizedBox(
              height: 10,
            ),
            FutureBuilder<AllEmployeeListModel>(
              future: attendanceRepository.getAllEmployeeList(),
              builder: (BuildContext context,
                  AsyncSnapshot<AllEmployeeListModel> snapshot) {
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
                     return  Container(
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,


                              childAspectRatio : 2/4,

                            ),
                            itemCount: 5,
                            itemBuilder: (BuildContext ctx, index) {
                              var data = CoursesJson[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
                                child: GestureDetector(


                                  child: CustomCourseCardExpand(
                                    thumbNail: data['image'],
                                    videoAmount: data['video'],
                                    title: data['title'],
                                    userProfile: data['user_profile'],
                                    userName: data['user_name'],
                                    price: data['price'],
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                }
              },
            ),
          ]),
        ),
      ),
    );
  }




}
