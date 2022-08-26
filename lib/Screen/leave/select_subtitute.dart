import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils.dart';

class SelectSubtitute extends StatelessWidget {
  const SelectSubtitute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroudColor,
        title:  Text('Leave Request',style: TextStyle(
            color: appBarHeader,fontSize: 24
        ),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
