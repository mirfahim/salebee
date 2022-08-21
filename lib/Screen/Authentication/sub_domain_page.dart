import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Data/static_data.dart';
import 'package:salebee/Helper/api_helper.dart';
import 'package:salebee/Screen/Authentication/login_page.dart';

import 'package:salebee/Screen/Home/home.dart';
import 'package:salebee/Service/api_service_dio.dart';
import 'package:provider/provider.dart';
import 'package:salebee/Utils/Alerts.dart';
import 'package:salebee/Widget/button_widget.dart';
import '../../Provider/Login/login_provider.dart';
import '../../Service/sharedPref_service.dart';
import '../../Utils/StringsConst.dart';

class SubDomainPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<SubDomainPage> {
  var textSubDomainController = TextEditingController();
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sub-domain",
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
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Sub-Domain",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: textSubDomainController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your sub-domain",
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  Map<String, dynamic> body = {
                    "hostname": textSubDomainController.text.toString(),
                  };
                  print("wrking 1");
                  try {
                    Map<String, dynamic> res = await getSubDomainResponse(body);
                    print(" my res is yo++++++ ${res['Result'][0]}");
                    if (res['Result']['data'] == "OK") {
                      setState(() {
                        SharedPreff.to.prefss.setString("subDomain",
                            textSubDomainController.text.toString());
                        StaticData.subDomain =
                            textSubDomainController.text.toString();
                        print("==================${StaticData.subDomain}");
                      });
                      Get.to(() => LoginPage());
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('Sub-domain did not match'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } catch (e) {
                    final snackBar = SnackBar(
                      content: const Text('Sub-domain did not match'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    print("erorr +++++++++++++ $e");
                  }

                  // print("my domain result ${res.status}");
                },
                child: CustomButton(
                  buttonText: "Submit",
                ),
              ),
              SizedBox(
                height: 20,
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

  getSubDomainResponse(body) async {
    try {
      Map<String, String> headerMap = {
        'Content-Type': 'application/json',
        // 'Accept': 'application/json'
      };
      Uri url = Uri.parse(
          "https://${textSubDomainController.text.toString()}.salebee.net/api/Salebee/CheckDomain?hostname=${textSubDomainController.text.toString()}");
      print("sub domin check utl is +++++++${url}");
      final response =
          await http.post(url, headers: headerMap, body: json.encode(body));
      Map<String, dynamic> res = jsonDecode(response.body);
      print("my res is $res");
      return res;
    } catch (e) {
      print(" my response error is $e");
    }
  }
}
