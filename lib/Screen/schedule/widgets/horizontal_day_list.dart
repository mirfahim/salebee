import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HorizontalDayList extends StatefulWidget {

  final Function dayUpdateFunction;

  const HorizontalDayList({Key? key, required this.dayUpdateFunction}) : super(key: key);

  @override
  _HorizontalDayListState createState() => _HorizontalDayListState();
}

class _HorizontalDayListState extends State<HorizontalDayList> {

  List<String> weekdays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

  Color activeCardColor = Colors.white;
  Color inactiveCardColor = Colors.black26;

  Color activeTextColor = Colors.black;
  Color inactiveTextColor = Colors.white;

  List<List<Color>> cardColorList = [
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
    [Colors.black26, Colors.white],
  ];

  late DateTime date;

  void updateDayColor(int index) {
    setState(() {
      for (int i = 0; i < cardColorList.length; i++) {
        cardColorList[i][0] = inactiveCardColor;
        cardColorList[i][1] = inactiveTextColor;
      }

      cardColorList[index][0] = activeCardColor;
      cardColorList[index][1] = activeTextColor;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      date = DateTime.now();
      widget.dayUpdateFunction(weekdays[date.weekday - 1]);
      updateDayColor(date.weekday - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekdays.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              updateDayColor(index);
              widget.dayUpdateFunction(weekdays[index]);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              height: 70,
              width: 50,
              decoration: BoxDecoration(
                  color: cardColorList[index][0],
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Center(
                child: Text(weekdays[index], style: TextStyle(fontSize: 18, color: cardColorList[index][1], fontWeight: FontWeight.bold),),
              ),
            ),
          );
        },
      ),
    );
  }
}