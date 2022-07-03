import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:salebee/Screen/SplashScreen.dart';
import 'package:provider/provider.dart';

import 'Provider/Login/login_provider.dart';
import 'Screen/Authentication/login_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
      ],
      child: GetMaterialApp(

        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
      ),
    );
  }
}




