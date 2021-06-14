import 'dart:ffi';
import 'package:axia_inventory/homescreen.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';

import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'consultation1.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'api.dart';

class modifierPwd extends StatefulWidget {
  @override
  _modifierPwdState createState() => _modifierPwdState();
  final String aname;
  final String email;
  final String url;
  final String prot2;
       final bool entre;
  final bool sortie;
  final bool transfer;
  final bool consult;
  final bool gestionutil;
  final bool inventaires;
  final bool protvalidation;
  
  modifierPwd({Key key, this.aname,this.email,this.url,this.prot2,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);
}

class _modifierPwdState extends State<modifierPwd> {

  TextEditingController protmPwdController = TextEditingController();


  TextEditingController   passwdController = TextEditingController();
  bool _isDisabled = false;
      String selectedName;
      bool  imagevalid=false;
      bool transfere=false;
      bool entree=false;
      bool sortie=false;
      bool inv=false;
      bool consult=false;
      bool iscolored=false;
      bool isloading=false;
     String msg="";
    List data = List();
    List<bool> boollist=List();
    List<bool> _switchValues = List.generate(7, (_) => false);
  int admin;
Future<http.Response> pwdEdit() async {
  var url = "https://${widget.url}/api/users/editpwd/${widget.prot2}/${widget.aname}";

  Map data = {
 "protmPwd":passwdController.text
};
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
 @override
  initState() {
  

    super.initState();
 
   
    
  }
  @override
  Widget build(BuildContext context) {


    

   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62959c),
        title: Text('Ajouter un utilisateur'),
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
                  MaterialPageRoute(builder: (context) => Menu(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
                );
              });
            },
          )
        ],
      ),
      drawer: ssd(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,),
      body: SingleChildScrollView(
        child: Container(
          child: Container(width:450,
            child: Column(
              
              children: [
                 Padding(
                  padding: const EdgeInsets.only(top:18.0),
                  child: CircleAvatar(backgroundColor: Colors.grey[350],radius: 58,
                              
                              child: Icon(Icons.person,size:80,color: Colors.white,)),
                ),
                   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.prot2}",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
                ),   Container(height: 50,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only( bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)))
                ,child: Center(child: Text("Changer le mot de passe",style: TextStyle(fontSize: 18,color: Colors.white)))),
                 
              Padding(
                padding: const EdgeInsets.only(top:30.0,left:28),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
      
                  Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
   
        SizedBox(height: 45,child: Center(child: Text('Nouveau mot de passe')),),
                      
                      SizedBox(height: 45,child: Center(child: Text('Confirmer Mot de passe')),),
                      
          
      
      
      
                  ],),
                  Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
      
      
                  Padding(
                     padding: const EdgeInsets.only(left:8.0,bottom: 8),
                     child: Container(
                  width: 200,
                  
                  child: TextField(
                    controller: passwdController,
                      obscureText: true,
                      decoration:new InputDecoration(
                  enabledBorder:iscolored==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),  
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
                  
                  
                  labelText: 'nouveau mot de passe',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: 'entrer le nouveau mot de passe',
                  hintStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                      ),
                  ),
                     ),
                   ),
         Padding(
                     padding: const EdgeInsets.only(left:8.0,bottom: 8),
                     child: Container(
                  width: 200,
                  
                  child: TextField(
                    controller: protmPwdController,
                      obscureText: true,
                      decoration:new InputDecoration(
                  enabledBorder:iscolored==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),  
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
            
                  
                  labelText: 'Confirmer mot de passe',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: 'entrer le mot de passe a nouveau',
                  hintStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                      ),
                  ),
                     ),
                   ),
             
             
                 
                   
  
                  ],),
      
      
                ],),
              ),
      
                
    
             
             
             isloading==false?   Padding(
                  padding: const EdgeInsets.only(top: 20.0,bottom: 50),
                  child: Center(
                    child: Container(
                      child: FlatButton(
                        child: Text('Enregistrer'),
                        color: Color(0xffec524b),
                        textColor: Colors.white,
                        minWidth: 100,
                        height: 50,
                        onPressed: () async { setState(() {
                          isloading=true;
                        });
                          if(passwdController.text==protmPwdController.text&& passwdController.text.length>=5){

                          await pwdEdit();
                        successDialog(context, "mot de passe a été changer",neutralAction:() {
                           Navigator.pop(context);
                           Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,)),
                );
              });
                        
                          }else if(passwdController.text==null ||protmPwdController.text ==null){setState(() {
                              iscolored=true;
                              msg="les champs est vide";
                          });
                          
                          }else{setState(() {
                            msg="Mot de passe ne correspond pas";
                            iscolored=true;
                          });
                            
                          }
                     
                          }
                    
                      ),
                    ),
                  ),
                ):CircularProgressIndicator(),
                iscolored==true? Text(msg,style: TextStyle(color: Colors.red),):SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
