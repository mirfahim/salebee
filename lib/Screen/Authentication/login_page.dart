import 'dart:async';
import 'dart:convert';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:battery_plus/battery_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Helper/api_helper.dart';
import 'package:salebee/Helper/location_helper.dart';
import 'package:salebee/Model/login_model.dart';

import 'package:salebee/Screen/Home/home.dart';
import 'package:salebee/Service/api_service_dio.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:salebee/Widget/bottom_bar.dart';
import 'package:salebee/Widget/button_widget.dart';
import 'package:salebee/bottomNav.dart';
import 'package:salebee/repository/add_task_repository.dart';
import 'package:salebee/repository/visit_repository.dart';
import '../../Provider/Login/provider_manager.dart';
import '../../Service/sharedPref_service.dart';
import '../../Utils/StringsConst.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../repository/lead_repository.dart';
import '../../repository/prospect_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var textUserController = TextEditingController();
  var textPwdController = TextEditingController();
  LeaDRepository leaDRepository = LeaDRepository();

  ProspectRepository prospectRepository = ProspectRepository();
  ApiService apiService = ApiService();
  List<LoginResponseModel> list = [];
  LoginResponseModel _allResponse = LoginResponseModel();
  LoginResponseModel loginResponseModel = LoginResponseModel();
  bool? checkedValue = false;
  bool circularLoad = false;
  String? fcmtoken = "";
  List<dynamic> todaysTaskList = [];
  TaskRepository taskRepository = TaskRepository();
  getFcmToken() async {
    fcmtoken = await FirebaseMessaging.instance.getToken();
    print("my fcm toekn is =+++++++++ $fcmtoken");
    return fcmtoken;
  }
  GeolocatorService geolocatorService = GeolocatorService();
  VisitRepository visitRepository = VisitRepository();
  String locationDis = "";
  var battery = Battery();
  getBattery()async{
    var bat = await  battery.batteryLevel;
    return bat;
  }
  void _login({String? email, String? pass}) async {
    FocusScope.of(context).unfocus();



    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: pass!,
      );
      if (!mounted) return;
     // Navigator.of(context).pop();
    } catch (e) {


      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Text(
            e.toString(),
          ),
          title: const Text('Error'),
        ),
      );
    }
  }
  void _register(
      {String? email, String? userName, String? pass, String? imageUrl}) async {
    FocusScope.of(context).unfocus();



    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: "123456",
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: userName,
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=$userName',
          lastName: "",
        ),
      );

      if (!mounted) return;
      Navigator.of(context)
        ..pop()
        ..pop();
    } catch (e) {
      print("${e.toString()}");
      if(e.toString() == "[firebase_auth/email-already-in-use] The email address is already in use by another account."){
        _login(email:email, pass: "123456" );
      } else{
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
            content: Text(
              e.toString(),
            ),
            title: const Text('Error'),
          ),
        );
      }



    }
  }
  getAddressFromLatLng( double lat, double lng) async {
    String mapApiKey = "AIzaSyAG8IAuH-Yz4b3baxmK1iw81BH5vE4HsSs";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print("response of api google ==== ${response.body}");
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        locationDis =  _formattedAddress;
        return locationDis;
      }
      return locationDis;
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    getFcmToken();
    super.initState();
  }
  getAllTask() {
    todaysTaskList.clear();
    taskRepository.getAssignedToMeTaskController().then((ele) {
      todaysTaskList.addAll(ele.result!
          .where((element) => element.dueDate!.day == DateTime.now().day));
      print("my todays task list is ${todaysTaskList.length}");
      StaticData.todaysTask = todaysTaskList.length;
    });
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
                        //StaticData.department = value["Result"]["UserFullName"];
                        StaticData.employeeID = value["Result"]["EmployeeId"];
                        StaticData.designation = value["Result"]["Designation"];
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
                        _register(email: textUserController.text, userName: loginResponseModel.result!.userFullName!, pass: textPwdController.text, imageUrl: "${StringsConst.MAINURL}" +
                            "${StaticData.proLink!.replaceAll("../..", "")}" );

                        prospectRepository.getAllProspectListByUserIdController().then((value) {
                          print("prospect data from splash $value");
                          StaticData.prosepctList = value.result!;
                          return value.result!;
                        });
                        leaDRepository.getLeadController().then((value) {
                          print("lead data from splash $value");
                          StaticData.leadList = value.result!;
                          return value.result!;
                        });


                        Timer(Duration(seconds: 3), () {
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(

                              builder: (BuildContext context) => BottomNav(A_MenuPage: false),
                            ),
                                (route) => false,//if you want to disable back feature set to false
                          );

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
    loginResponseModel.result!.menus!.forEach((element) {
      if(element.label == "Attendance"){
        SharedPreff.to.prefss
            .setBool("attendanceMenu", true);
      }
    });
    StaticData.attendanceMenu = SharedPreff.to.prefss.getBool("attendanceMenu");
    SharedPreff.to.prefss.setBool("loggedIN", true);
    SharedPreff.to.prefss
        .setString("userNAME", "${loginResponseModel.result?.userFullName}");

    SharedPreff.to.prefss
        .setString("token", "${loginResponseModel.result?.userToken}");
    SharedPreff.to.prefss.setString(
        "proLink", "${loginResponseModel.result?.userProfileImageLink}");
    SharedPreff.to.prefss.setString(
        "designation", "${loginResponseModel.result?.designation}");
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
