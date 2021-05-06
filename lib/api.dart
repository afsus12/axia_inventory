import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<http.Response> loginUser(String user, String pass ,String uri) async {
  var url = 'https://$uri/login';

  Map data = {
    'protmUser': user,
    'protmPwd': pass,
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
Future<http.Response> loginUsdder() async {
  var url = 'https://192.168.1.8:8000/api/users/add';

  Map data = {
    "protmUser": "testss",
  "protmPwd": "test123",
  "protmDescription" :"testss",
  "protmRight":true,
  "protmEmail":"afsayassines@gmail.com",
  "protmUserprofil":"testss",
  "protmAdministrator":1,
  "deCode":"DEP0101",
  "cbcreateur":"testss",
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}


