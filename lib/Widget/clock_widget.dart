// // package to create analog clock
// import 'package:analog_clock/analog_clock.dart';
// import 'package:flutter/material.dart';
//
// import '../Utils/my_colors.dart';
//
//
//
// class CustomWatch extends StatefulWidget {
//   Color watchColor;
//   CustomWatch(this.watchColor);
//
//   @override
// // ignore: library_private_types_in_public_api
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<CustomWatch> {
//   @override
// // building the app widgets
//   Widget build(BuildContext context) =>
//     AnalogClock(
//         decoration: BoxDecoration(
//             border: Border.all(width: 3.0, color: Colors.black),
//             color: widget.watchColor,
//             shape: BoxShape.circle), // decoration
//         width: 200.0,
//         isLive: true,
//         hourHandColor: Colors.black54,
//         minuteHandColor: Colors.black,
//         showSecondHand: true,
//         numberColor: Colors.black,
//         showNumbers: true,
//         textScaleFactor: 1.5,
//         showTicks: true,
//         showDigitalClock: true,
//         digitalClockColor: Colors.white,
//         datetime: DateTime.now(),
//       ); // center
//
//
// }
