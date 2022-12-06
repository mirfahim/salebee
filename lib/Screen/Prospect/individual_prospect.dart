import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:salebee/Model/prospect/get_prospect_model.dart';
import 'package:salebee/Screen/Prospect/create_prospect/create_prospect.dart';
import 'package:salebee/Screen/Prospect/create_prospect/create_prospect_front.dart';
import 'package:salebee/Screen/leave/leave_details.dart';
import 'package:salebee/repository/prospect_repository.dart';
import 'package:salebee/utils.dart';




class IndividualProspect extends StatefulWidget {
  const IndividualProspect({Key? key}) : super(key: key);

  @override
  State<IndividualProspect> createState() => _IndividualProspectState();
}

class _IndividualProspectState extends State<IndividualProspect> {
  String searchString = "";
  List result = [];
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
                                    return  InkWell(
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
                                              )

                                            ],
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