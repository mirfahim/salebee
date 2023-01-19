import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee/Helper/location_helper.dart';

import 'package:salebee/Screen/Prospect/create_prospect/create_prospect.dart';
import 'package:salebee/Screen/Prospect/create_prospect/create_prospect_front.dart';
import 'package:salebee/Screen/Prospect/prospect_details.dart';
import 'package:salebee/Screen/leave/leave_details.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/prospect_repository.dart';
import 'package:salebee/repository/visit_repository.dart';
import 'package:salebee/utils.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../Model/employee/employee_list_model.dart';
import '../../Model/prospect/get_prospectList_by_id_model.dart';
import '../../Service/sharedPref_service.dart';
import '../../repository/attendance_repository.dart';




class IndividualProspect extends StatefulWidget {
  const IndividualProspect({Key? key}) : super(key: key);

  @override
  State<IndividualProspect> createState() => _IndividualProspectState();
}

class _IndividualProspectState extends State<IndividualProspect> {
  String searchString = "";
  AttendanceRepository attendanceRepository = AttendanceRepository();
  VisitRepository visitRepository = VisitRepository();
  GeolocatorService geolocatorService = GeolocatorService();
  bool loader = false;
  String locationDis = "";
  List<ProspectResult> result = [];
  String stageName = "";
  List<String> stage = [
    'New Prospect',
    'Initial Contact',
    ''
  ];
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  TaskRepository taskRepository = TaskRepository();
  TextEditingController textNoteController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  List<StageModel> stageList = [
    StageModel("New prospect", Colors.greenAccent, 1011),
    StageModel("Initial Contact", Colors.blueAccent, 1012),
    StageModel("On followup", Colors.redAccent, 1013),
    StageModel("Visited", Colors.orangeAccent, 1014),
    StageModel("Lead Created", Colors.purpleAccent, 1),
    StageModel("Hot Lead", Colors.grey, 1016),
    StageModel("Already Client", Colors.grey, 0),
    StageModel("Test1019", Colors.grey, 1019),


  ];

  List<ActivityModel> activityList = [
    ActivityModel("Lead", Colors.greenAccent, 1, Icon(Icons.rocket,), 2),
    ActivityModel("Quote", Colors.greenAccent, 1, Icon(Icons.message_outlined,), 2),
    ActivityModel("Order", Colors.greenAccent, 1, Icon(Icons.add_shopping_cart,), 2),
    ActivityModel("Call", Colors.greenAccent, 1, Icon(Icons.call,), 2),
    ActivityModel("Message", Colors.blueAccent, 2,Icon(Icons.message), 6),
    ActivityModel("Meeting", Colors.redAccent, 3, Icon(Icons.table_bar), 0),
    ActivityModel("Visit", Colors.orangeAccent, 4, Icon(Icons.map), 1),



  ];
  ProspectRepository prospectRepository = ProspectRepository();
  @override
  void initState() {
    super.initState();
    super.initState();
    attendanceRepository.getAllEmployeeList().then((value) {
      AttendanceRepository.employeeList = value.results!;

      print("my emp list from pros ${AttendanceRepository.employeeList[0].employeeId} ");
    });
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(_searchController.text);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 55 ,
        color: primaryColorLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: InkWell(
            onTap: (){
              Get.to( CreateProspectFront());
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: darkBlue
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Create Prospect',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: size.height,
        color: primaryColorLight,
        child: SafeArea(
          child: SingleChildScrollView(
            child:   Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        onChanged: (e) {

                          setState(() {
                            searchString = e;
                          });

                        },

                        controller: _searchController,
                        decoration: InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)))),
                      ),
                    ),
                  ),
                  FutureBuilder<GetAllProspectByIdtModel>(
                    future: prospectRepository.getAllProspectListByUserIdController(),
                    builder: (BuildContext context,
                        AsyncSnapshot<GetAllProspectByIdtModel> snapshot) {

                      if (snapshot.data == null) {
                        print("no data found");
                      } else {
                        result = _search(snapshot.data!.result);
                      }

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
                              height: MediaQuery.of(context).size.height -200,
                              child: ListView.separated(

                                itemCount: result!.length,
                                itemBuilder: (BuildContext context , index){
                                  var data = result![index];

                                  if(data.isIndividual == true){
                                    return  ExpandableNotifier(
                                      child: InkWell(
                                        onTap: (){
                                          Get.to( ProspectDetails(data: data, prospectName: data.prospectName,
                                            stage: data.stage!,
                                            createdby: getEmp(data.createdBy!, AttendanceRepository.employeeList),
                                            industry: data.industry,
                                            createdOn: data.createdOn,
                                            assignto: getEmp(data.assignTo!, AttendanceRepository.employeeList),
                                            concernPerson: data.concernPerson,
                                            note: data.importantNote,
                                          ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: const Color(0xFFFFFFFF)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Pro -${data.id}',style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 12,
                                                        color: Colors.grey
                                                    ),),
                                                    const SizedBox(height: 10,),
                                                    Text("${DateFormat.yMMM().format(data.createdOn!)}",style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400
                                                    )),

                                                  ],
                                                ),
                                                ListTile(
                                                    trailing: Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(

                                                          border: Border.all(
                                                              color: borderColor, width: 1),
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(10.0))

                                                      ),
                                                      child: Center(
                                                        child:  Text(data.stage!,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 12,
                                                              color: Colors.black54
                                                          ),),
                                                      ),
                                                    ),

                                                    title:Text(data.prospectName!,style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 12,
                                                        color: Colors.black
                                                    ),),
                                                    subtitle: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(data.zone!),
                                                        Text(data.website!),
                                                        Text("Industry"),
                                                        data.concernPerson!.isEmpty ?
                                                        Text("No data",style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                        ),) : Text(data.concernPerson![0].name.toString() ,style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14,
                                                            color: Colors.grey
                                                        ),

                                                        ),
                                                        data.concernPerson!.isEmpty ?
                                                        Text("No data",style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                        ),) : Text(data.concernPerson![0].designation.toString(),style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                        ),

                                                        ),
                                                        data.concernPerson!.isEmpty ?
                                                        Text("No data",style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                        ),) : Text(data.concernPerson![0].mobile.toString(),style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                        ),

                                                        ),
                                                      ],
                                                    )

                                                ),


                                                ScrollOnExpand(
                                                  scrollOnExpand: true,
                                                  scrollOnCollapse: false,
                                                  child: ExpandablePanel(
                                                    theme:
                                                    const ExpandableThemeData(
                                                      headerAlignment:
                                                      ExpandablePanelHeaderAlignment
                                                          .center,
                                                      tapBodyToCollapse:
                                                      true,
                                                    ),
                                                    header: Row(
                                                      children: [
                                                        const Text(
                                                          'Pick Any',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                             _textMe(data.concernPerson![0].mobile!.toString());
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .chat,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                             launchPhoneDialer(
                                                                 data.concernPerson![0].mobile!.toString());
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .call,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          splashColor:
                                                          Colors.blue,
                                                          onTap: () {
                                                                _launchWhatsapp(data.concernPerson![0].mobile!.toString());
                                                          },
                                                          child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100)),
                                                            child:
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .messenger,
                                                                  color:
                                                                  primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  100)),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  8.0),
                                                              child: Icon(
                                                                Icons
                                                                    .more_horiz,
                                                                color:
                                                                primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    collapsed:
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    expanded: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),

                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .airline_seat_recline_normal_sharp,
                                                              color: Colors
                                                                  .grey,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              decoration:
                                                              const BoxDecoration(
                                                                  shape:
                                                                  BoxShape.circle),
                                                              child:
                                                              const CircleAvatar(
                                                                radius: 12,
                                                                backgroundImage:
                                                                AssetImage(
                                                                  'images/suite.png',
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),

                                                            Text(
                                                              getEmp(data.createdBy! ?? 1, AttendanceRepository.employeeList),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                  14),
                                                            )

                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Action',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                      14,
                                                                      fontWeight:
                                                                      FontWeight.w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: (){
                                                                    _showMyDialog(data.prospectName!, data.id!);
                                                                  },

                                                                  child: Card(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius.circular(100)),
                                                                    child:
                                                                    Container(
                                                                      decoration:
                                                                      BoxDecoration(shape: BoxShape.circle),
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.all(8.0),
                                                                        child:
                                                                        Text(
                                                                          "Visit",
                                                                          style: TextStyle(
                                                                            color: primaryColor,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Card(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(100)),
                                                                  child:
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(shape: BoxShape.circle),
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child:
                                                                      Icon(
                                                                        Icons.edit,
                                                                        color:
                                                                        primaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),


                                                                Card(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(100)),
                                                                  child:
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(shape: BoxShape.circle),
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child:
                                                                      Icon(
                                                                        Icons.delete,
                                                                        color:
                                                                        Colors.red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  50,
                                                                ),


                                                                Container()

                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          child: ListView.separated(

                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: activityList.length,
                                                            itemBuilder: (BuildContext context , index){


                                                              return  Row(
                                                                children: [
                                                                  Badge(
                                                                    badgeContent: index == 0 ?
                                                                    Text(data.followupLogActivity!.leadCount.toString()):
                                                                    index == 1 ?
                                                                    Text(data.followupLogActivity!.quoteCount.toString()):
                                                                    index == 2 ?
                                                                    Text(data.followupLogActivity!.orderCount.toString()):
                                                                    index == 3 ?
                                                                    Text(data.followupActivity!.call.toString()):
                                                                    index == 4 ?
                                                                    Text(data.followupActivity!.message.toString()):
                                                                    index == 5 ?
                                                                    Text(data.followupActivity!.meeting.toString()):

                                                                    Text(data.followupActivity!.visit.toString()),
                                                                    badgeColor: primaryColorLight,
                                                                    child: Card(
                                                                      elevation: 5,
                                                                      child: Container(
                                                                        width: MediaQuery.of(context).size.width * .11,
                                                                        height: 40,
                                                                        child: Column(
                                                                          children: [

                                                                            InkWell(
                                                                              onTap: (){

                                                                              },

                                                                              child: CircleAvatar(
                                                                                radius: 10,
                                                                                backgroundColor: Colors.transparent,

                                                                                child: activityList[index].icon,

                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 5,),
                                                                            Expanded(

                                                                              child: Text(activityList[index].activityName!,

                                                                                style: TextStyle(
                                                                                    color: Colors.grey,
                                                                                    fontSize: 7
                                                                                ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 10,)
                                                                ],
                                                              );





                                                            },
                                                            separatorBuilder: (context, index) {
                                                              return SizedBox(width: 0,);
                                                            },),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),



                                          ),
                                        ),
                                      ),
                                    );

                                  }
                                  return  Container();
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },),
                            );
                          }
                      }
                    },
                  ),
                ]
            ),

          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String prospectName, int prospectID) async {
    loader = false;
    String? token = SharedPreff.to.prefss.getString("token");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter visit note..'),

                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: textNoteController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Note',

                      hintText: 'Description'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: loader == true ? Center(child: CircularProgressIndicator(),): Text('Cancel', style: TextStyle(
                  color: Colors.red
              ),),
              onPressed: () async {

                Navigator.pop(context);

              },
            ),
            TextButton(
              child: loader == true ? Center(child: CircularProgressIndicator(),): Text('Done'),
              onPressed: () async {
                setState(() {
                  loader = true;
                });
                taskRepository
                    .taskAddController(
                    token: token!,
                    title: "Visited to $prospectName",
                    description: textNoteController.text,
                    type: 1,
                    repeat: 1,
                    priority: 1,
                    prospectId: prospectID,
                    status: 4,
                    leadID: 0,
                    assignaTo: 0) .then((value) {
                  if (value.isSuccess == true) {
                    addVisit(prospectName, prospectID);
                    _showSnack(value.message!);

                    setState(() {
                      loader = false;
                    });
                    // Get.to(OtherExpense());
                  } else {
                    _showSnack(value.message!);

                    setState(() {
                      loader = false;
                    });
                  }
                });
                Navigator.pop(context);
                //  _getLocation();
              },
            ),
          ],
        );
      },
    );
  }
  getAddressFromLatLng( double lat, double lng) async {
    String mapApiKey = "AIzaSyAG8IAuH-Yz4b3baxmK1iw81BH5vE4HsSs";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print("response of api google ==== ${response.body}");
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        locationDis =  _formattedAddress;
        return locationDis;
      }
      return locationDis;
    }


  }
  addVisit(String? prospect, int? prospectID){

    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");
    geolocatorService.determinePosition().then((ele) {
      print("my position is ${ele!.latitude}");
      getAddressFromLatLng(ele.latitude!, ele.longitude!).then((e){
        visitRepository.visitAddController(prospectName: prospect!, locationTime: DateTime.now(), employeeId: 2149,
            latitude: ele.latitude!, longitude: ele.longitude!, batteryStatus: "30", prospectId: prospectID!, location: e
        );
      });



    });
  }
  getEmp(int id, List<Results> list) {
    List<Results> p = [];
    p.add(list.where((element) => element.employeeId == id).first);
    return p[0].employeeName;
  }
  getStage(int id) {

    List<StageModel> p = [];
    p.clear();
    p.add(stageList.where((element) => element.id == id).first);
    return p[0].stageName;
  }

  void _showSnack(String msg) {
    final _snackBarContent = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(_scaffoldkey.currentState!.context)
        .showSnackBar(_snackBarContent);
  }
  List<ProspectResult> _search(List<ProspectResult>? employee) {
    if(searchString.isNotEmpty == true) {
      //search logic what you want
      return employee?.where((element) => element.prospectName!.toLowerCase().contains(searchString))
          .toList() ?? <ProspectResult>[];
    }

    return employee ?? <ProspectResult>[];
  }
  _launchWhatsapp(String num) async {
    var whatsapp = "+88${num}";
    var whatsappAndroid =
    Uri.parse("whatsapp://send?phone=$whatsapp&text=hello Sir");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  _textMe(num) async {
    // Android
    var uri = 'sms:+88${num.toString()}?body= Hellow Sir';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:+8801782084390?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }
}


class StageModel {
  String? stageName;
  int? id;
  Color? color ;

  StageModel(this.stageName, this.color, this.id);
}


class ActivityModel {
  String? activityName;
  int? id;
  Color? color ;
  Icon icon;
  int count;

  ActivityModel(this.activityName, this.color, this.id, this.icon, this.count);
}