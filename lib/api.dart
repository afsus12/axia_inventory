import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

<<<<<<< HEAD
Future<http.Response> loginUser(String user, String pass) async {
  var url = '192.168.1.33:8000/login';

  Map data = {
    'protmUser': user,
    'protmPwd': pass,
=======
Future<http.Response> loginUser (String user,String  pass) async {
  var url ='https://192.168.1.8:8000/login';

  Map data = {
    'protmUser':  user,
    'protmPwd' : pass,
>>>>>>> 77cd90ebedc720c63215388d58021c2b096ecd5a
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
