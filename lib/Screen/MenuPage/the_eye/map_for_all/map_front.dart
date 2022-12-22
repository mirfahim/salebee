import 'package:flutter/material.dart';
import 'package:salebee/Screen/MenuPage/the_eye/map_for_all/map_view.dart';

class MapFront extends StatelessWidget {
  const MapFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - 200,
          width: MediaQuery.of(context).size.width - 200,
          child: EyeMapScreeen()),
    );
  }
}
