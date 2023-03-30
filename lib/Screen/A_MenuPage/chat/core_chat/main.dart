import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'rooms.dart';



class MyAppChat extends StatelessWidget {
  const MyAppChat({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Firebase Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:  RoomsPage(),
      );
}
