import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/task/task_main.dart';
import 'package:salebee/Screen/test/food_item.dart';

import '../../utils.dart';

class StationFood extends StatefulWidget {
  const StationFood({Key? key}) : super(key: key);

  @override
  State<StationFood> createState() => _StationFoodState();
}

class _StationFoodState extends State<StationFood> {
  String? selectName;
  List<StationModel> stationList = [
    StationModel(id: 1, stationName: "Komlapur", address: "dhaka", time: "20"),
    StationModel(id: 1, stationName: "Komlapur1", address: "dhaka", time: "20"),

    StationModel(id: 1, stationName: "Komlapur2", address: "dhaka", time: "20"),

    StationModel(id: 1, stationName: "Komlapur3", address: "dhaka", time: "20"),

    StationModel(id: 1, stationName: "Komlapur4", address: "dhaka", time: "20"),

    StationModel(id: 1, stationName: "Komlapur5", address: "dhaka", time: "20"),

    StationModel(id: 1, stationName: "Komlapur6", address: "dhaka", time: "20"),

    StationModel(id: 1, stationName: "Komlapur7", address: "dhaka", time: "20"),

    StationModel(id: 1, stationName: "Komlapur8", address: "dhaka", time: "20"),

    StationModel(id: 1, stationName: "Komlapur9", address: "dhaka", time: "20"),

  ];

  @override
  Widget build(BuildContext context) {
    selectName = stationList[0].stationName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Station Food"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 20,
            ),
            Container(
              height: 20,
              child: Text("Select Train"),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: selectName,
              icon: Icon(Icons.arrow_drop_down_outlined),
              elevation: 16,
              style: const TextStyle(
                  color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.

              },
              items:stationList
                  .map((value) {
                return DropdownMenuItem<String>(
                  value: value.stationName.toString(),
                  child: Text(value.stationName.toString()),
                );
              }).toList(),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: stationList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                      Get.to(FoodItemList());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColorSecond,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    stationList[index].stationName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text(stationList[index].address!),
                              Text("Estimated time to reach", style: TextStyle(fontSize: 8),),
                              Text(stationList[index].time! + "min"),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
 class StationModel{
  String? stationName;
  int? id;
  String? address;
  String? time;

  StationModel({this.id, this.time, this.address, this.stationName});


}