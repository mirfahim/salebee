import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform/platform.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

// customize this one

enum apiMethods { get, post, patch, delete, put }
class Alerts {


  bool circular = false;
  TextEditingController emailChanePassTextEditingController =
  TextEditingController();
  static showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  static Future<void> show(context, title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("t.ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  static Future<void> showAuthError(context, title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("t.ok"),
              onPressed: () {
                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                //     Register()), (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
  // static Future<void> rateAppDialouge(context, title, message) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: SingleChildScrollView(
  //           child: Text(message),
  //         ),
  //         actions: <Widget>[
  //           Column(
  //             children:[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children:[
  //                   TextButton(
  //                     child: Text("AppBajar",style: TextStyle(fontWeight: FontWeight.bold),),
  //                     onPressed: ()  async{
  //                       const url = 'https://appbajar.com/en/app/com.holytune.app?id=3509#';
  //
  //                       if (await canLaunch(url)) {
  //                         await launch(url, forceWebView: true);
  //                       } else {
  //                         throw 'Could not launch $url';
  //                       }
  //                     },
  //                   ),
  //                   TextButton(
  //                     child: Text("Playstore", style: TextStyle(fontWeight: FontWeight.bold),),
  //                     onPressed: () {
  //
  //                     },
  //                   ),
  //       ]
  //               ),
  //               TextButton(
  //                 child: Text("Send Feedback"),
  //                 onPressed: ()  async{
  //                   const url = 'https://accounts.google.com/signin/v2/identifier?service=mail&passive=true&rm=false&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F%3Ftab%3Drm%26ogbl&scc=1&ltmpl=default&ltmplcache=2&emr=1&osid=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin';
  //
  //                   if (await canLaunch(url)) {
  //                     await launch(url, forceWebView: true);
  //                   } else {
  //                     throw 'Could not launch $url';
  //                   }
  //                 },
  //               ),
  //               TextButton(
  //                 child: Text("Close"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //       ]
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  static Future<void> showCupertinoAlert(context, title, message) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text(title),
              content: new Text(message),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("t.ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  static showProgressDialog(BuildContext context, String title) {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Flexible(
                      flex: 8,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            );
          });
    } catch (e) {
      print(e.toString());
    }
  }

  static subscriptionloginrequiredhint(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("t.loginrequired"),
          content: Text("t.loginrequiredhint"),
          actions: <Widget>[
            TextButton(
              child: Text("t.cancel.toUpperCase()"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("t.login.toUpperCase()"),
              onPressed: () {
                // Navigator.of(context).pop();
                // Navigator.pushNamed(context, LoginScreen.routeName);
              },
            )
          ],
        );
      },
    );
  }

  static showPlaySubscribeAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("t.subscribehint"),
          content: Text("t.playsubscriptionrequiredhint"),
          actions: <Widget>[
            TextButton(
              child: Text("t.cancel.toUpperCase()"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("t.subscribe"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  static showPreviewSubscribeAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("t.subscribehint"),
          content: Text("t.previewsubscriptionrequiredhint"),
          actions: <Widget>[
            TextButton(
              child: Text("t.cancel.toUpperCase()"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("t.subscribe"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
