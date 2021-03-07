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
                child: Image(image:AssetImage('images/logo2.png'),width: 300,),
                 
                  
              ),
              ),
   Padding(
   padding: EdgeInsets.all(10),
   child: TextField(
       decoration: InputDecoration(
         
       border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 10, 
                style: BorderStyle.solid,
            )),
       labelText: 'User Name',
       hintText: 'user not valid'
     ),
     
   ),
 ),
      Padding(
   padding: EdgeInsets.all(10),
   child: TextField(
       obscureText: true,
       decoration: InputDecoration(
       border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 10, 
                style: BorderStyle.solid,
            ),),
       labelText: 'Password',
       hintText: 'Enter your secure password'
     ),
   ),
 ) 
 , Center( 
   child: Container( 
     
     width: 150, height: 50,   decoration: BoxDecoration( color: Colors.blue[700],
    border: Border.all( 
           color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15))
  ),
     child: FlatButton(onPressed: (){},  child: Text('Login',style: TextStyle(color: Colors.white, fontSize: 25)),
     
                   
     
     ),
   ),
 )



 
 
 
 
 
 ],
    ),
  ),
  
  );
  }
}