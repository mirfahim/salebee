import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salebee/repository/prospect_repository.dart';
import 'package:salebee/utils.dart';

import '../../Model/followUp/followUP_by_prospectID_model.dart';

class FollowUpList extends StatefulWidget {
  int? prospectId;

   FollowUpList({Key? key, this.prospectId}) : super(key: key);

  @override
  State<FollowUpList> createState() => _FollowUpListState();
}

class _FollowUpListState extends State<FollowUpList> {
  ProspectRepository prospectRepository = ProspectRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            FutureBuilder<GetFollowupListModel>(
              future: prospectRepository.getProspectFollowupByIdController(widget.prospectId!),
              builder: (BuildContext context,
                  AsyncSnapshot<GetFollowupListModel> snapshot) {
                if (snapshot.data == null) {
                  print("no data found++++");
                } else {
                  print("success +++++=");
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                        child: LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color(0xFF8686E3),
                          rightDotColor: const Color(0xFFEA3799),
                          size: 100,
                        ));
                  default:
                    if (snapshot.hasError)
                      return Center(child: Text('No Data Found'));
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                          height: 500,
                          child: DefaultTabController(
                            length: 8,
                            child: Scaffold(
                              body: Container(
                                color: primaryColorLight,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 12,
                                              child: Container(
                                                height: 60,
                                                child: TabBar(
                                                  indicatorColor: darkBlue,
                                                  labelColor: darkBlue,
                                                  unselectedLabelColor:
                                                      tabBarUnSelectedColor,
                                                  unselectedLabelStyle:
                                                      const TextStyle(
                                                          fontSize: 12),
                                                  labelStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  isScrollable: true,
                                                  tabs: [
                                                    badges.Badge(
                                                      badgeContent: Text(snapshot.data!.result!.call!.length.toString(), style: TextStyle(fontSize: 10),),
                                                      badgeColor:
                                                          Colors.greenAccent,
                                                      child: Tab(
                                                        text: 'Call',
                                                      ),
                                                    ),
                                                    badges.Badge(
                                                      badgeContent: Text(snapshot.data!.result!.message!.length.toString(), style: TextStyle(fontSize: 10),),
                                                      badgeColor:
                                                          Colors.greenAccent,
                                                      child: Tab(
                                                        text: 'Message',
                                                      ),
                                                    ),
                                                    badges.Badge(
                                                      badgeContent: Text(snapshot.data!.result!.meeting!.length.toString(), style: TextStyle(fontSize: 10),),
                                                      badgeColor:
                                                          Colors.greenAccent,
                                                      child: Tab(
                                                        text: 'Meeting',
                                                      ),
                                                    ),
                                                    badges.Badge(
                                                      badgeContent: Text(snapshot.data!.result!.visit!.length.toString(), style: TextStyle(fontSize: 10),),
                                                      badgeColor:
                                                          Colors.greenAccent,
                                                      child: Tab(
                                                        text: 'Visit',
                                                      ),
                                                    ),
                                                    badges.Badge(
                                                      badgeContent: Text(snapshot.data!.result!.others!.length.toString(), style: TextStyle(fontSize: 10),),
                                                      badgeColor:
                                                          Colors.greenAccent,
                                                      child: Tab(
                                                        text: 'Others',
                                                      ),
                                                    ),
                                                    badges.Badge(
                                                      badgeContent:Text(snapshot.data!.result!.email!.length.toString(), style: TextStyle(fontSize: 10),),
                                                      badgeColor:
                                                          Colors.greenAccent,
                                                      child: Tab(
                                                        text: 'Email',
                                                      ),
                                                    ),
                                                    badges.Badge(
                                                      badgeContent:Text(snapshot.data!.result!.sms!.length.toString(), style: TextStyle(fontSize: 10),),
                                                      badgeColor:
                                                          Colors.greenAccent,
                                                      child: Tab(
                                                        text: 'SMS',
                                                      ),
                                                    ),
                                                    badges.Badge(
                                                      badgeContent:Text(snapshot.data!.result!.file!.length.toString(), style: TextStyle(fontSize: 10),),
                                                      badgeColor:
                                                          Colors.greenAccent,
                                                      child: Tab(
                                                        text: 'File',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(child: Container())
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: TabBarView(children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: Container(
                                                height: 400,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!
                                                        .result!.call!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            index) {
                                                      var data = snapshot.data!
                                                          .result!.call![index];
                                                      return Card(
                                                        child: ListTile(
                                                          title: Text(
                                                              data!.titles!, style: TextStyle(
                                                            fontSize: 10,
                                                          ),),
                                                          subtitle: Text(data!
                                                              .description!, style: TextStyle(
                                                            fontSize: 9,
                                                          ),),
                                                          trailing: Container(
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  color: primaryColorSecond
                                                                      .withOpacity(
                                                                          .3),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
                                                              width: 70,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat('EEEE').format(data!.date!).toString().substring(0, 3) +
                                                                              ",",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            " " +
                                                                                data!.date!.toString().substring(8, 10),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(fontSize: 8),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          DateFormat('MMM')
                                                                              .format(data!.date!)
                                                                              .toString()
                                                                              .substring(0, 3),
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Card(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            DateFormat.jm().format(data!.date!),
                                                                            style:
                                                                                TextStyle(fontSize: 8),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                        ),
                                                      );
                                                    }),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!
                                                      .result!.message!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = snapshot
                                                        .data!
                                                        .result!
                                                        .message![index];
                                                    return Card(
                                                      child: ListTile(
                                                        title:
                                                            Text(data!.titles!),
                                                        subtitle: Text(
                                                            data!.description!),
                                                        trailing: Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: primaryColorSecond
                                                                    .withOpacity(
                                                                        .3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat('EEEE').format(data!.date!).toString().substring(0,
                                                                                3) +
                                                                            ",",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          " " +
                                                                              data!.date!.toString().substring(8, 10),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        DateFormat('MMM')
                                                                            .format(data!
                                                                                .date!)
                                                                            .toString()
                                                                            .substring(0,
                                                                                3),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm()
                                                                              .format(data!.date!),
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    );
                                                  })),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!
                                                      .result!.meeting!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = snapshot
                                                        .data!
                                                        .result!
                                                        .meeting![index];
                                                    return Card(
                                                      child: ListTile(
                                                        title:
                                                            Text(data!.titles!),
                                                        subtitle: Text(
                                                            data!.description!),
                                                        trailing: Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: primaryColorSecond
                                                                    .withOpacity(
                                                                        .3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat('EEEE').format(data!.date!).toString().substring(0,
                                                                                3) +
                                                                            ",",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          " " +
                                                                              data!.date!.toString().substring(8, 10),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        DateFormat('MMM')
                                                                            .format(data!
                                                                                .date!)
                                                                            .toString()
                                                                            .substring(0,
                                                                                3),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm()
                                                                              .format(data!.date!),
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    );
                                                  })),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!
                                                      .result!.visit!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = snapshot.data!
                                                        .result!.visit![index];
                                                    return Card(
                                                      child: ListTile(
                                                        title:
                                                            Text(data!.titles!),
                                                        subtitle: Text(
                                                            data!.description!),
                                                        trailing: Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: primaryColorSecond
                                                                    .withOpacity(
                                                                        .3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat('EEEE').format(data!.date!).toString().substring(0,
                                                                                3) +
                                                                            ",",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          " " +
                                                                              data!.date!.toString().substring(8, 10),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        DateFormat('MMM')
                                                                            .format(data!
                                                                                .date!)
                                                                            .toString()
                                                                            .substring(0,
                                                                                3),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm()
                                                                              .format(data!.date!),
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    );
                                                  })),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!
                                                      .result!.others!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = snapshot.data!
                                                        .result!.others![index];
                                                    return Card(
                                                      child: ListTile(
                                                        title:
                                                            Text(data!.titles!),
                                                        subtitle: Text(
                                                            data!.description!),
                                                        trailing: Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: primaryColorSecond
                                                                    .withOpacity(
                                                                        .3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat('EEEE').format(data!.date!).toString().substring(0,
                                                                                3) +
                                                                            ",",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          " " +
                                                                              data!.date!.toString().substring(8, 10),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        DateFormat('MMM')
                                                                            .format(data!
                                                                                .date!)
                                                                            .toString()
                                                                            .substring(0,
                                                                                3),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm()
                                                                              .format(data!.date!),
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    );
                                                  })),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!
                                                      .result!.email!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = snapshot.data!
                                                        .result!.email![index];
                                                    return Card(
                                                      child: ListTile(
                                                        title: Text(
                                                            data!.subject!),
                                                        subtitle:
                                                            Text(data!.body!),
                                                        trailing: Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: primaryColorSecond
                                                                    .withOpacity(
                                                                        .3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat('EEEE').format(data!.createdOn!).toString().substring(0,
                                                                                3) +
                                                                            ",",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          " " +
                                                                              data!.createdOn!.toString().substring(8, 10),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        DateFormat('MMM')
                                                                            .format(data!
                                                                                .createdOn!)
                                                                            .toString()
                                                                            .substring(0,
                                                                                3),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm()
                                                                              .format(data!.createdOn!),
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    );
                                                  })),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!
                                                      .result!.sms!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = snapshot.data!
                                                        .result!.sms![index];
                                                    return Card(
                                                      child: ListTile(
                                                        title: Text(
                                                            data!.mobileNo!),
                                                        subtitle: Text(
                                                            data!.message!),
                                                        trailing: Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: primaryColorSecond
                                                                    .withOpacity(
                                                                        .3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat('EEEE').format(data!.createdOn!).toString().substring(0,
                                                                                3) +
                                                                            ",",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          " " +
                                                                              data!.createdOn!.toString().substring(8, 10),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        DateFormat('MMM')
                                                                            .format(data!
                                                                                .createdOn!)
                                                                            .toString()
                                                                            .substring(0,
                                                                                3),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm()
                                                                              .format(data!.createdOn!),
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    );
                                                  })),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!
                                                      .result!.file!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    var data = snapshot.data!
                                                        .result!.file![index];
                                                    return Card(
                                                      child: ListTile(
                                                        title: Text(data!.id!
                                                            .toString()),
                                                        subtitle:
                                                            Text(data!.remark!),
                                                        trailing: Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: primaryColorSecond
                                                                    .withOpacity(
                                                                        .3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                            width: 70,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          4.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat('EEEE').format(data!.createdOn!).toString().substring(0,
                                                                                3) +
                                                                            ",",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      //"LogTimeIn":"2022-09-13T08:36:40.32"
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          " " +
                                                                              data!.createdOn!.toString().substring(8, 10),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        DateFormat('MMM')
                                                                            .format(data!
                                                                                .createdOn!)
                                                                            .toString()
                                                                            .substring(0,
                                                                                3),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat.jm()
                                                                              .format(data!.createdOn!),
                                                                          style:
                                                                              TextStyle(fontSize: 8),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    );
                                                  })),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
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
