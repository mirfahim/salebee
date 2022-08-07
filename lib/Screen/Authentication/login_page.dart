import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Helper/api_helper.dart';

import 'package:salebee/Screen/Home/home.dart';
import 'package:salebee/Service/api_service_dio.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Utils/Alerts.dart';
import '../../Provider/Login/login_provider.dart';
import '../../Utils/StringsConst.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var textUserController = TextEditingController();
  var textPwdController = TextEditingController();
  ApiService apiService = ApiService();
  ApiClient apiClient = ApiClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: textUserController,
            decoration: InputDecoration(
              hintText: "User Name",
            ),
          ),
          TextField(

            controller: textPwdController,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ), // hlw
          TextButton(
              onPressed: () {
                Provider.of<UserAuthProvider>(context, listen: false).signIN(
                    textUserController.text.toString(),
                    textPwdController.text.toString());
                Map<String, dynamic> bodyString = {
                  "phone_number": "01782084390",
                  "password": "12345678",
                };
                var header = {
                  "Keydata": 8741214584542,
                  // "Host" : "<calculated when request is sent>",
                  // "Content-Type": "multipart/form-data"
                  'Content-Type': 'multipart/form-data',
                  //"Accept": "application/json",
                };
               // httpPost();
                 postData();
              // apiClient.post(url: "delivery_boy_login", body: bodyString);
              //   apiService.makeApiRequest(
              //      method: apiMethods.post , url: "delivery_boy_login", body: bodyString, headers :header
              //   );
                //  Get.to(()=>HomePage());
              },
              child: Text("Login"))
        ],
      ),
    );
  }




  void httpPost() async {
    var header = {
      "Keydata": "8741214584542",




    // 'Content-Type': 'multipart/form-data',
      //"Accept": "application/json",
    };
    // This will be sent as form data in the post requst
    var map = new Map<String, dynamic>();
    map['mobile_number'] = '01782084390';
    map['password'] = '12345678';

    final response = await http.post(
      Uri.parse('https://myzoo.asia/api/delivery_boy_login'),
      body: map,
      headers: header,
    );

    print(response.body);
    print(response.statusCode);
  }
  //http.Response? response;
  //http.MultipartRequest? request;
  Uri apiURL = Uri.parse("https://myzoo.asia/api/delivery_boy_login");
  postData() async {
    Map <String, String>  headerMap = {
      'Keydata' : '8741214584542',
      'Content-type': 'application/json'
    };
    var request =  http.MultipartRequest("POST", apiURL);
    request.headers.addAll(headerMap);
    request.fields['phone_number'] = '01782084390';
    request.fields['password'] = '12345678';

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    if (response.statusCode == 200)
    {
      print("response successful");
    }
  }
}
