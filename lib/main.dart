
import 'dart:io';

import 'package:flutter/material.dart';
import 'login.dart';
void main() {
  runApp(MaterialApp(
    
    home:login(),
  ));
  HttpOverrides.global = new MyHttpOverrides();
}
 class MyHttpOverrides extends HttpOverrides{ 
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
      
  }
}