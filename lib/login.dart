import 'package:flutter/material.dart';


class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/sfsqf.png'),
      fit: BoxFit.cover,
    ),
  ),
  child: Scaffold(
    backgroundColor: Colors.transparent,
    body: ListView(
      children: <Widget>[  
        Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Image(image:AssetImage('logo2.png'),width: 450,),
                 
                  
              ),
              ),
   Padding(
   padding: EdgeInsets.all(10),
   child: TextField(
       decoration: InputDecoration(
       border: OutlineInputBorder(),
       labelText: 'User Name',
       hintText: 'Enter valid mail id as abc@gmail.com'
     ),
   ),
 ),
      Padding(
   padding: EdgeInsets.all(10),
   child: TextField(
       obscureText: true,
       decoration: InputDecoration(
       border: OutlineInputBorder(),
       labelText: 'Password',
       hintText: 'Enter your secure password'
     ),
   ),
 ) ],
    ),
  ),
  
  );
  }
}