import 'package:flutter/material.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';




class MonthsReportTab extends StatelessWidget {
  MonthsReportTab({Key? key}) : super(key: key);
  var listitems = [
    'item1','item2','item3','item4','item5','item6','item7','item8','item9','item10','item11','item12','item13','item14','item15','item16','item18','item19','item20'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: TabbedList(
            tabLength: 12,
            sliverTabBar: const SliverTabBar(
                tabBar: TabBar(
                  labelColor: Colors.black,
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize: 8),

                  tabs: [
                    Tab(
                      text: 'Jan',
                    ),
                    Tab(
                      text: 'Feb',
                    ),
                    Tab(
                      text: 'Mer',
                    ),
                    Tab(
                      text: 'Apr',
                    ),
                    Tab(
                      text: 'May',
                    ),
                    Tab(
                      text: 'Jun',
                    ),
                    Tab(
                      text: 'Jul',
                    ),
                    Tab(
                      text: 'Aug',
                    ),
                    Tab(
                      text: 'Sep',
                    ),Tab(
                      text: 'Oct',
                    ),
                    Tab(
                      text: 'Nov',
                    ),

                    Tab(
                      text: 'Dec',
                    )
                  ],
                )),
            tabLists: [
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page1',
                  length: listitems.length,
                  builder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page2',
                  length: listitems.length,
                  builder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  }),
              TabListBuilder(
                  uniquePageKey: 'page3',
                  length: listitems.length,
                  builder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(listitems[index].toString()),
                          tileColor: Colors.white,
                        ));
                  })
            ]
      ),
    );
  }
}