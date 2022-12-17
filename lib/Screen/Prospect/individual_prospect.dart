import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salebee/Helper/location_helper.dart';
import 'package:salebee/Model/prospect/get_prospect_model.dart';
import 'package:salebee/Screen/Prospect/create_prospect/create_prospect.dart';
import 'package:salebee/Screen/Prospect/create_prospect/create_prospect_front.dart';
import 'package:salebee/Screen/leave/leave_details.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/prospect_repository.dart';
import 'package:salebee/repository/visit_repository.dart';
import 'package:salebee/utils.dart';

import '../../Service/sharedPref_service.dart';




class IndividualProspect extends StatefulWidget {
  const IndividualProspect({Key? key}) : super(key: key);

  @override
  State<IndividualProspect> createState() => _IndividualProspectState();
}

class _IndividualProspectState extends State<IndividualProspect> {
  String searchString = "";
  GeolocatorService geolocatorService = GeolocatorService();
  bool loader = false;
  VisitRepository visitRepository = VisitRepository();
  List result = [];
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  TaskRepository taskRepository = TaskRepository();
  TextEditingController textNoteController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  List<StageModel> stageList = [
    StageModel("New prospect", Colors.greenAccent, 1),
    StageModel("Initial Contact", Colors.blueAccent, 2),
    StageModel("On followup", Colors.redAccent, 3),
    StageModel("Visited", Colors.orangeAccent, 4),
    StageModel("Lead Created", Colors.purpleAccent, 5),
    StageModel("Hot Lead", Colors.grey, 6),
    StageModel("Already Client", Colors.grey, 7),


  ];
  ProspectRepository prospectRepository = ProspectRepository();
  @override
  void initState() {
    super.initState();
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
                  FutureBuilder<GetProspectListModel>(
                    future: prospectRepository.getAllProspectController(),
                    builder: (BuildContext context,
                        AsyncSnapshot<GetProspectListModel> snapshot) {

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

                                  if(data.isIndividual == false){
                                    return  ExpandableNotifier(
                                      child: InkWell(
                                        onTap: (){
                                          Get.to(const LeaveDetails());
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
                                                    Text('25 Aug 2022',style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400
                                                    )),

                                                  ],
                                                ),
                                                ListTile(
                                                  trailing: Text("Since 83 days",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 12,
                                                        color: Colors.black54
                                                    ),),

                                                  title:Text(data.name!,style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12,
                                                      color: Colors.black
                                                  ),),
                                                  subtitle: data.contactPersonName == null ?
                                                  Text("No data",style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12,
                                                      color: Colors.grey
                                                  ),) : Text(data.contactPersonName!,style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12,
                                                      color: Colors.grey
                                                  ),),

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
                                                            // _textMe(455);
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
                                                            // launchPhoneDialer(
                                                            //     "2424");
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
                                                            //    _launchWhatsapp( 356.toString());
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
                                                              "No Data",
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
                                                                    _showMyDialog(data.name!, data.id!);
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
                                                          height: 30,
                                                          child: ListView.separated(

                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: stageList.length,
                                                            itemBuilder: (BuildContext context , index){


                                                              return  Card(
                                                                elevation: 5,
                                                                child: Container(
                                                                  width: MediaQuery.of(context).size.width * .11,
                                                                  child: Column(
                                                                    children: [

                                                                      InkWell(
                                                                        onTap: (){

                                                                        },

                                                                        child: CircleAvatar(
                                                                          radius: 4,
                                                                          backgroundColor: stageList[index].id! <= 3 ? stageList[index].color : Colors.grey,

                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 5,),
                                                                      Expanded(

                                                                        child: Text(stageList[index].stageName!,

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
                    addVisit(prospectName);
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
  addVisit(String? prospect){

    print("working 1 ${SharedPreff.to.prefss.get("token")} ++++++");
    geolocatorService.determinePosition().then((ele) {
      print("my position is ${ele!.latitude}");

      visitRepository.visitAddController(prospectName: prospect!, locationTime: DateTime.now(), employeeId: 2149,
        latitude: ele.latitude!, longitude: ele.longitude!, batteryStatus: "30"
        );


    });
  }

  void _showSnack(String msg) {
    final _snackBarContent = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(_scaffoldkey.currentState!.context)
        .showSnackBar(_snackBarContent);
  }
  List<Result> _search(List<Result>? employee) {
    if(searchString.isNotEmpty == true) {
      //search logic what you want
      return employee?.where((element) => element.name!.toLowerCase().contains(searchString))
          .toList() ?? <Result>[];
    }

    return employee ?? <Result>[];
  }
}


class StageModel {
  String? stageName;
  int? id;
  Color? color ;

  StageModel(this.stageName, this.color, this.id);
}