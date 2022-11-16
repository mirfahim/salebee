import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Helper/api_helper.dart';
import 'package:salebee/Model/login_model.dart';

import 'package:salebee/Screen/Home/home.dart';
import 'package:salebee/Service/api_service_dio.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:salebee/Widget/bottom_bar.dart';
import 'package:salebee/Widget/button_widget.dart';
import 'package:salebee/bottomNav.dart';
import '../../Provider/Login/provider_manager.dart';
import '../../Service/sharedPref_service.dart';
import '../../Utils/StringsConst.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var textUserController = TextEditingController();
  var textPwdController = TextEditingController();
  ApiService apiService = ApiService();
  List<LoginResponseModel> list = [];
  LoginResponseModel _allResponse = LoginResponseModel();
  LoginResponseModel loginResponseModel = LoginResponseModel();
  bool? checkedValue = false;
  bool circularLoad = false;
  String? fcmtoken = "";

  getFcmToken() async {
    fcmtoken = await FirebaseMessaging.instance.getToken();
    print("my fcm toekn is =+++++++++ $fcmtoken");
    return fcmtoken;
  }

  @override
  void initState() {
    // TODO: implement initState
    getFcmToken();
    super.initState();
  }

  // ApiClient apiClient = ApiClient();
  @override
  Widget build(BuildContext context) {
    print("${SharedPreff.to.prefss.getString("subDomain")}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                child: Text(
                  "Log in",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                "Enter your credintial to access account",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              )),
              SizedBox(
                height: 40,
              ),
              Text(
                "Email address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: textUserController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your email",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: textPwdController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      circularLoad = true;
                    });

                    Provider.of<ProviderManager>(context, listen: false).signIN(
                        textUserController.text.toString(),
                        textPwdController.text.toString());

                    // res.map((data) =>  LoginResponseModel.fromJson(data)).toList();

                    // LoginResponseModel modelObject = LoginResponseModel.fromJson(res);

                    // listData =  res.map((data) =>  LoginResponseModel.fromJson(data))
                    //       .toList();
                    loginController().then((value) {
                      print("qqqqqqq${value['IsSuccess']}");
                      if (value['IsSuccess'] == false) {
                        final snackBar = SnackBar(
                          content: const Text(
                              'Please login with valid email or password'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          circularLoad = false;
                        });
                      }
                      setState(() {
                        loginResponseModel = LoginResponseModel.fromJson(value);
                        StaticData.name = value["Result"]["UserFullName"];
                        StaticData.employeeID = value["Result"]["EmployeeId"];
                        StaticData.proLink =
                            value["Result"]["UserProfileImageLink"];
                        print(
                            "yo bro ----- ${loginResponseModel.result?.menus?.length.toString()}");
                      });
                      if (loginResponseModel.isSuccess == true) {
                        setState(() {
                          circularLoad = false;
                        });
                        setPref();
                        Timer(Duration(seconds: 3), () {
                          Get.to(() => BottomNav());
                        });

                        print("go to homepage ____________");
                      }
                    });

                    // print("yo bro ----- ${loginResponseModel.isSuccess}");

                    //
                  },
                  child: CustomButton(
                    buttonState: circularLoad,
                    buttonText: "Login",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    child: Center(
                      child: CheckboxListTile(
                        title: Text(
                          "Remember me",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                  ),
                  Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ],
              ),
              Center(
                child: Text.rich(TextSpan(
                    text: 'Do you want to register your company?',
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Help & Support',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  setPref() {
    SharedPreff.to.prefss.setBool("loggedIN", true);
    SharedPreff.to.prefss
        .setString("userNAME", "${loginResponseModel.result?.userFullName}");
    SharedPreff.to.prefss
        .setString("token", "${loginResponseModel.result?.userToken}");
    SharedPreff.to.prefss.setString(
        "proLink", "${loginResponseModel.result?.userProfileImageLink}");
    SharedPreff.to.prefss
        .setInt("employeeID", loginResponseModel.result!.employeeId!);
  }

  Future<dynamic> loginController() async {
    print(
        "working 1 fcm token $fcmtoken device id is +++ ${StaticData.deviceID}");
    // Map<String, dynamic> bodyString = {
    //   "Email": textUserController.text.toString(),
    //   "UserName": textUserController.text.toString(),
    //   "Password": textPwdController.text.toString(),
    //   "RememberMe": true,
    //   "Token": "string",
    //   "FCM_Token": fcmtoken,
    //   "DeviceId": "String"
    // };
    Map<String, dynamic> bodyString = {
      "Email": "string",
      "UserName": textUserController.text.toString(),
      "Password": textPwdController.text.toString(),
      "RememberMe": true,
      "Token": "string",
      "FCM_Token": fcmtoken,
      "DeviceId": StaticData.deviceID
    };


    return
        //  apiClient.post(url: "delivery_boy_login", body: bodyString);
        apiService.makeApiRequest(
            method: apiMethods.post,
            url: "Login",
            body: bodyString); //we will fetch the overview from this request
  }
}
