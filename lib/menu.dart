import 'package:flutter/material.dart';

void main() {
  runApp(Menu())
  ;
}
class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      home: Container(decoration: BoxDecoration(gradient:LinearGradient(
          begin: Alignment.topRight,
              end: Alignment.bottomLeft, 
                colors: [
                  Color(0xffA7D3F1),
                  Color(0xffFFFFFF), ])),
        child: Scaffold( backgroundColor: Colors.transparent, appBar: AppBar(backgroundColor: Color(0xff62959C), title:Text('Acceuil'), centerTitle: true,),
        body: GridView.count(crossAxisCount: 2
        ,children: [ CircleAvatar(  backgroundColor: Colors.transparent, foregroundImage: AssetImage('images/in.png'),
          radius: 40,
          child: Container( 
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(begin: Alignment.topRight,
              end: Alignment.bottomLeft,
                colors: [
                  Color(0xffDE6262),
                  Color(0xffFFB88C),
                ],
              ),
            ),
          ),
        ),


        ],),
                           






        ),
      ),
    )
      
    ;
  }
}
