import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<http.Response> loginUser(String user, String pass) async {
<<<<<<< HEAD
  var url = 'https://192.168.1.9:8000/login';
=======
  var url = 'https://192.168.1.34:8000/login';
>>>>>>> 7a78732304449dda0548a78786aa8b2fc8a78392

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
