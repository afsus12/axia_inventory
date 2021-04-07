
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<http.Response> loginUser (String user,String  pass) async {
  var url ='https://192.168.1.14:8000/login';

  Map data = {
    'protUser':  user,
    'protPwd' : pass,
  };
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}