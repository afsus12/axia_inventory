import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<http.Response> role(
  int admin,
  String cb,
) async {
  var url = 'https://192.168.1.9:8000/api/users/addroles';

  Map data = {
    'protmAdministrator': admin,
    'cbCreateur': cb,
  };
}

Future<http.Response> loginUser(String user, String pass, String uri) async {
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

Future<http.Response> loginUsdder(
  String protmUserController,
  String protmPwdController,
  String protmDescriptionController,
  String protmEmailController,
  String protmUserprofilController,
  int admin,
  String decodeController,
  String cb,
  String url,
) async {
  var uri = 'https://$url/api/users/add';

  Map data = {
    'protmUser': protmUserController,
    'protmPwd': protmPwdController,
    'protmDescription': protmDescriptionController,
    'protmRight': true,
    'protmEmail': protmEmailController,
    'protmUserprofil': protmUserprofilController,
    'protmAdministrator': admin,
    'deCode': decodeController,
    'cbCreateur': cb,
  };

  var body = json.encode(data);

  var response = await http.post(Uri.parse(uri),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
