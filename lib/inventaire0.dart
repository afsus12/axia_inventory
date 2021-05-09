import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';

import 'menu.dart';


class invacc extends StatefulWidget {
  @override
  _invaccState createState() => _invaccState();

  final String aname;
  final String email;
  final String url;
  invacc({Key key, this.aname, this.email,this.url}) : super(key: key);
}

class _invaccState extends State<invacc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff62959c),
          title: Text('Inventaire'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}")),
                  );
                });
              },
            )
          ],
        ),drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}"),
        body:Column( 
          children: [


             Padding(
               padding: const EdgeInsets.only(top:200.0),
               child: Center(
                 child: SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: FloatingActionButton(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        onPressed: () {},
                                    
                                
                                        child: Icon(Icons.add),
                                          ),
                                        ),
               ),
             )
          ],



        ),
        
        
        
        ));
  }
}