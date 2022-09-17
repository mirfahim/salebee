import 'dart:convert';
import 'dart:io';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:salebee/Utils/Alerts.dart';
import 'dart:convert' as convert;

import 'package:salebee/Utils/StringsConst.dart';




class ApiService {


  Future<String> uploadFile(File file, String type) async {
    String url = StringsConst.BASEURL;

    // final creds = await authRepository.getCredentials();

    final headers = {
     // 'Authorization': 'Bearer ' + storage.read("token")
      "Content-Type": "application/json",
    };

    String fileName = file.path.split('/').last;

    final body = {
      "type": type,
    };

    /*final form = FormData({
      'image':
          MultipartFile(File(file.path).readAsBytesSync(), filename: fileName),
      'type': type,
    });

    final response = await post(
      url,
      form,
      headers: headers,
    );
    return response;*/

    http.Response? response;
    http.MultipartRequest request;

    try {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields.addAll(body)
        ..files.add(await http.MultipartFile.fromPath("image", file.path,
            filename: fileName));

      response = await http.Response.fromStream(await request.send());
    } on SocketException {
      Fluttertoast.showToast(msg: "Please check your internet connection");
    } catch (e) {
      rethrow;
    }
    return response!.body;
  }
  Future<String> apiRequestWithMultipart({method, url, body, headers}) async {



    Uri apiURL = Uri.parse(StringsConst.BASEURL + url);




    http.Response? response;
    http.MultipartRequest request;

    try {
      request = http.MultipartRequest('POST', apiURL)
        ..headers.addAll(headers)
        ..fields.addAll(body);


      response = await http.Response.fromStream(await request.send());
      print("my response is ${response.body}");
    } on SocketException {
      Fluttertoast.showToast(msg: "Please check your internet connection");
    } catch (e) {
      rethrow;
    }
    return response!.body;
  }

  makeApiRequest({method, url, Map? body, headers}) async {
    print("working started on api request 00");
    print("$method");
    try {
      print("working started on api request 01");
      http.Response response;
      Uri apiURL = Uri.parse(StringsConst.BASEURL + url);
      print("working started on api request 02");
      var header = headers;
      final encoding = Encoding.getByName('utf-8');
      // use storage // getx storage
      // if (headers == null) {
      //   header = {
      //     "Content-Type" : "multipart/form-data",
      //     "Keydata" : "8741214584542",
      //     //"Authorization": 'Bearer ' + storage.read("token")
      //   };
      // }
      if (method == apiMethods.post) {

       Map bodys = {
          'phone_number' : '01782084390',
          'password' : '12345678',

        };
       Map <String, String>  headerMap = {
         'Keydata' : '8741214584542',



    // "Access-Control-Allow-Origin": "*"


    };
        var bodyString = json.encode(bodys);
        print("started working on POST REQUEST $bodyString $headerMap $apiURL");
        response = await http.post(apiURL,
            body: bodyString, headers: headerMap,);
        print("Response code: ${response.statusCode}");
        // print('response code from function: ${response.statusCode}');
        print('response code from function: ${response.body}');
        print(apiURL);
        // print(response.body);
      }


      if (method == apiMethods.get) {
        response = await http.get(apiURL, headers: header);
        print("my response is $response");
      }
      if (method == apiMethods.delete) {
        response = await http.delete(apiURL, headers: header);
      }
      if (method == apiMethods.put) {
        response = await http.put(apiURL,
            body: convert.jsonEncode(body), headers: header, );
        print('response code from put: $apiURL');
        print('response code from put: ${response.body}');
      }

      if ((response.statusCode == 200 || response.statusCode == 201)) {
        var res = convert.jsonDecode(response.body);
        print("my response is $res");
        return res;
      } else if ((response.statusCode == 403)) {
        var res = convert.jsonDecode(response.body);
        print("my response is $res");
        return res;
      } else {
        var res = convert.jsonDecode(response.body);

        handleError(res);
      }
    } catch (e) {
      print(e.toString());
      handleError(e);
    }
  }

  handleError(err) {
    var message = 'Something went wrong. Please try again later';
    print(message);
    if (err != null && err['message'] != null && err['message'].length > 0) {
      message = err['message'][0];
    }
    Alerts.showToast(message);
  }

  // makePostRequest() async {
  //
  //   final uri = Uri.parse('http://httpbin.org/post');
  //   final headers = {'Content-Type': 'application/json'};
  //   Map<String, dynamic> body = {'id': 21, 'name': 'bob'};
  //   String jsonBody = json.encode(body);
  //   final encoding = Encoding.getByName('utf-8');
  //
  //   Response response = await post(
  //     uri,
  //     headers: headers,
  //     body: jsonBody,
  //     encoding: encoding,
  //   );
  //
  //   int statusCode = response.statusCode;
  //   String responseBody = response.body;
  // }
}
