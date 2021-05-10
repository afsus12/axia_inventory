import 'package:axia_inventory/ajouterUtilisateur.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'menu.dart';
import 'inventairehistclass.dart';
import 'dart:ffi';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';



import 'package:auto_size_text/auto_size_text.dart';





import 'sidemenu.dart';


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
 List <dynamic>data= List();
final List<Hisinv> invHislist = <Hisinv>[];
   Future getAllName() async {
    var response = await http.get(
        Uri.parse('https://${widget.url}/api/inventaire/getstoklist/${widget.aname}'),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
 
    
    var n= jsonData.length;
    for(var index=0;index<n;index++){var dateFormat;
DateTime dateTime = DateTime.parse(jsonData[index]['is_date']);
  setState(() {
    invHislist..add(Hisinv(jsonData[index]['pi_intitule'], jsonData[index]['fa_codefamille'], jsonData[index]['de_code'],dateTime, jsonData[index]['is_remarques'], jsonData[index]['is_valide'], jsonData[index]['cbcreateur']));
  }); 
    }

    print(jsonData);
    return "success";
  }
  @override
  initState() {
    final List<Hisinv> invHislist = <Hisinv>[];
    super.initState();
    getAllName();
    
  }
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
             ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff2193b0),
                          Color(0xff6dd5ed),
                        ])),child:Center(child: Text('Historique des inventaires'))),
        
        
         Expanded(
           child: SizedBox(height: 200.0,
             child: ListView.builder( itemCount: invHislist.length,shrinkWrap: true,
                      scrollDirection: Axis.vertical,
               itemBuilder: (context, index) {
                 double c_width = MediaQuery.of(context).size.width * 0.37;String formattedDate = DateFormat('yyyy/MM/dd \n kk:mm').format(invHislist[index].isDate);
           
                     return Container(
                       child: Card( child: Stack(children: [
                    Align(alignment: Alignment.topLeft,child: Row(children: [Icon(
                                          Icons.fiber_manual_record,
                                          color: Colors.orange,
                                          size: 13,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ), Text(invHislist[index].piIntitule)],) ,),
                    Column(
                               
                      children: [
                      
                            
                             Padding(
                                            padding: const EdgeInsets.only(left:10.0,top: 20),
                                            child: Container(




                                              child:Text(invHislist[index].isRemarques+'\n'+invHislist[index].faCodefamille),
                                            )
                                          ),

                          ]),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0 ,right: 8),
                        child: Align(alignment:Alignment.topRight,child: Text(formattedDate ,textAlign:TextAlign.center,)),
                      ),
                      Row(
                                            children: [
                                              Container(width: c_width,
                                                child: new Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                 
                                                       
                                                        new Text(invHislist[index].deCode,
                                                            style: TextStyle(fontSize: 13)),
                                                    SizedBox(height: 3,),
                                                  new  Text(channelList[index].barcode,
                                                            style: TextStyle(fontSize: 13)),
                                                  SizedBox(height: 3,),
                                                  
                                                
                                                    new    Text(channelList[index].deDepot,
                                                            style: TextStyle(fontSize: 13)),
                                                  
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                              


                       ]
                     )));
           
           
           
           
               }),
           ),
         )
          ],
              


        ),
        
        
        
        ));
  }
}