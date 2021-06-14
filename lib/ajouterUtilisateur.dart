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

class ajouterUtilisateur extends StatefulWidget {
  @override
  _ajouterUtilisateurState createState() => _ajouterUtilisateurState();
  final String aname;
  final String email;
  final String url;
    final bool entre;
  final bool sortie;
  final bool transfer;
  final bool consult;
  final bool gestionutil;
  final bool inventaires;
  final bool protvalidation;

  ajouterUtilisateur({Key key, this.aname,this.email,this.url,this.entre,this.sortie,this.transfer,this.consult,this.gestionutil,this.inventaires,this.protvalidation}) : super(key: key);
}

class _ajouterUtilisateurState extends State<ajouterUtilisateur> {
  TextEditingController protmUserController = TextEditingController();
  TextEditingController protmPwdController = TextEditingController();
  TextEditingController decodeController = TextEditingController();
  TextEditingController protmDescriptionController = TextEditingController();
  TextEditingController protmRightController = TextEditingController();
  TextEditingController protmEmailController = TextEditingController();
  TextEditingController protmUserprofilController = TextEditingController();
  TextEditingController protmAdministratorController = TextEditingController();
  TextEditingController cbcreateurController = TextEditingController();
  TextEditingController protmPwdController2 = TextEditingController();
    TextEditingController cemployerController = TextEditingController();
  bool _isDisabled = false;
      String selectedName;
       String selectedem;
      bool  imagevalid=false;
      bool transfere=false;
      bool entree=false;
      bool sortie=false;
      bool inv=false;
      bool consult=false;
      bool validinv=false;
      bool _iscolored=false;
      bool _iscolored1=false;
      bool _iscolored2=false;
      bool _iscolored3=false;
      bool _iscolored4=false;
      bool _iscolored5=false;
      bool _iscolored6=false;
      bool _iscolored7=false;
      bool isloading=false;
      String decodes;
    List data = List();
        List data2 = List();
    List<bool> boollist=List();
    List<bool> _switchValues = List.generate(7, (_) => false);
    List erreurmsg=List();
    
  int admin;
  String _msg='';
   Future getAllName() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/Depot/selection/${widget.aname}"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      data = jsonData;
    });
   
    print(jsonData);





   
    return "success";
  }

  validate()
  { var ok=true;
    if(protmUserController.text==''){

                           setState(() {
                             _iscolored=true;
                             erreurmsg..add("Nom utilisateur est obligatoire");
                             ok=false;
                           });
                           
                         } else if(protmUserController.text.length<=5){
                         
                         setState(() {
                           ok=false;
                             _iscolored=true;
                            erreurmsg..add("nom utilisateur:5 caractères minimum");
                         });
                         
                         }
                         if(protmPwdController.text==''&& protmPwdController2.text==''){

                            setState(() {
                              _iscolored1=true;
                              _iscolored2=true;
                              ok=false;
                                erreurmsg..add("Mot de passe est obligatoire");
                            });
                           
                          
                         }else if(protmPwdController.text.length <=5 ){

                          
                             setState(() {
                                erreurmsg..add("Mot de passe:5 caractères minimum");
                              _iscolored1=true;
                              _iscolored2=true;
                              ok=false;
                            });
                         }else if(protmPwdController.text !=protmPwdController2.text){
                           
                             setState(() {
                                erreurmsg..add(" Mot de passe ne correspond pas");
                              _iscolored1=true;
                              _iscolored2=true;
                              ok=false;
                            });
                         }
                         
                       if(protmDescriptionController.text==''){

                            setState(() {
                              _iscolored3=true;
                              ok=false;
                                 erreurmsg..add(" Description est vide");
                            });
                         
                         } if(protmEmailController.text==''){

                            setState(() {
 erreurmsg..add(" l'email est vide");
                                   ok=false;
                              _iscolored4=true;
                            });
                            
                         }else if( protmEmailController.text.length <6){
                                
                                 setState(() {
                                   erreurmsg..add("l'email n'est pas valide");
                                      ok=false;
                                      _iscolored4=true;
                                 });
                         }
                         
                         
                          if(protmUserprofilController.text==''){

                            setState(() {
                              ok=false;
                              _iscolored5=true;
                                   erreurmsg..add(" le nom de profile est vide");
                            });
                         
                         }

                          if(selectedName==''){

                            setState(() {
                              _iscolored6=true;
                              ok=false;
                                erreurmsg..add(" la selection de depot est obligatoire");
                            });
                           
                         }
                          if(cemployerController.text==''){

                            setState(() {
                              _iscolored7=true;
                              ok=false;
                                 erreurmsg..add("le code employee est obligatoire");
                            });

                          
                         }

 return ok;

  }
  msgs(remplir){
for(var i=0;i<remplir.length;i++){

         _msg=_msg+'*'+remplir[i]+'\n';
}
return _msg;
}
  Future getAllem() async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/em/prot/"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState(() {
      data2 = jsonData;
    });
   
    print(jsonData);





   
    return "success";
  }
  Future<http.Response> loginUsdder(bango,
  String protmUserController,
  String protmPwdController,
  String protmDescriptionController,
  String protmEmailController,
  String protmUserprofilController,
  bool right,
  int admin,
  String decodeController,
  String cb,
  String emcode,
) async {
  var uri = 'https://${widget.url}/api/users/add';
 for (var i=0;i<bango.length;i++){
     if(bango[i]['deIntitule']==selectedName){
       setState(() {
         decodes=bango[i]['deCode'];
       });
     }
 }
 if(_isDisabled==false){
   setState(() {
     admin=0;
   });
 }else{
  setState(() {
     admin=1;
   });
 }
  Map data = {
    'protmUser': protmUserController,
    'protmPwd': protmPwdController,
    'protmDescription': protmDescriptionController,
    'protmRight': right,
    'protmEmail': protmEmailController,
    'protmUserprofil': protmUserprofilController,
    'protmAdministrator': admin,
    'emCode':emcode,
    'deCode': decodes,
    'cbCreateur': cb,
  };

  var body = json.encode(data);

  var response = await http.post(Uri.parse(uri),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
 Future<http.Response> depadd(bango) async {
  var url = 'https://${widget.url}/api/users/depotutil';

 
  Map data = {
"protmUser":protmUserController.text,
 "deCode":bango,
 "cbCreateur":'${widget.aname}'
};
  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
Future<http.Response> rolesadd() async {
  var url = 'https://${widget.url}/api/users/addroles';

  Map data = {
"protmUser": protmUserController.text,
  "cbcreateur":"${widget.aname}",
  "maAccessentree":entree,
  "maAccesssortie":sortie,
  "maAccesstransfert":transfere,
  "maAccessinventaire":inv,
  "maAccessconsultaiton":consult,
  "maAccessgestionutil": false,
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
  
  getAllName();
   getAllem();  
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
                                                    protvalidation:widget.protvalidation,
                                       )),
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
                                                    protvalidation:widget.protvalidation,
                                       ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(width:450,
            child: Column(
              
              children: [
              Padding(
                padding: const EdgeInsets.only(top:48.0,right:48,left:48),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
      
                  Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
      
        SizedBox(height: 45,child: Center(child: Text('Nom utilisateur')),),
                      
                      SizedBox(height: 45,child: Center(child: Text('Mot de passe')),),
                       SizedBox(height: 45,child: Center(child: Text(' ')),),
                      
                   SizedBox(height: 45,child:  Center(child: Text('Description')),),
                     
                  SizedBox(height: 45,child: Center(child: Text('Email')),),
                    
                     SizedBox(height: 45,child: Center(child: Text('Nom de profile'))),
           
                      SizedBox(height: 45,child: Center(child: Text('Depot'))),
                       SizedBox(height: 45,child: Center(child: Text('Code employé'))),
                      
      
      
      
                  ],),
                  Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
      
      
                  Padding(
                     padding: const EdgeInsets.only(left:8.0,bottom: 8),
                     child: Container(
                  width: 200,
                  
                  child: TextField(onChanged: (value){
                       setState(() {
                         _iscolored=false;
                       });
                  },
                    controller: protmUserController,
                      obscureText: false,
                      decoration:new InputDecoration(
                  enabledBorder:  _iscolored==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
            
                  
                  labelText: 'Nom utilisateur',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: 'entrer le nom de utilisateur',
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
                    onChanged: (value){
                       setState(() {
                         _iscolored1=false;
                         _msg='';
                         erreurmsg.clear();
                       });
                  },
                    controller: protmPwdController,
                      obscureText: true,
                      decoration:new InputDecoration(
                  enabledBorder:_iscolored1==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30))),  
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
            
                  
                  labelText: 'mot de passe',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: 'entrer le mot de passe',
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
                             onChanged: (value){
                       setState(() {
                         _iscolored2=false;
                         _msg='';
                         erreurmsg.clear();
                       });
                  },
                    controller: protmPwdController2,
                      obscureText: true,
                      decoration:new InputDecoration(
                  enabledBorder: _iscolored2==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30))),  
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
            
                  
                  labelText: 'Confirmer mot de passe',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: 'entrer le mot de passe',
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
                                 onChanged: (value){
                       setState(() {
                         _iscolored3=false;
                         _msg='';
                         erreurmsg.clear();
                       });
                  },
                    controller: protmDescriptionController,
                      obscureText: false,
                      decoration:new InputDecoration(
                  enabledBorder: _iscolored3==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30))),  
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
            
                  
                  labelText: 'Description',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: 'entrer la Description',
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
                                     onChanged: (value){
                       setState(() {
                         _iscolored4=false;
                         _msg='';
                         erreurmsg.clear();
                       });
                  },
                    controller: protmEmailController,
                      obscureText: false,
                      decoration:new InputDecoration(
                  enabledBorder:_iscolored4==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30))),  
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
            
                  
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: "entrer l'email",
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
                                     onChanged: (value){
                       setState(() {
                         _iscolored5=false;
                         _msg='';
                         erreurmsg.clear();
                       });
                  },
                    controller: protmUserprofilController,
                      obscureText: false,
                      decoration:new InputDecoration(
                  enabledBorder: _iscolored5==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30))),  
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
            
                  
                  labelText: 'Nom de profile',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: 'entrer le Nom de profile',
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
                  height: 35,
                  decoration: ShapeDecoration(
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side:  _iscolored6==false? BorderSide(
                width: 0.6, style: BorderStyle.solid):BorderSide(
                width: 2, style: BorderStyle.solid,color: Colors.red),
                   ),
                  ),
                  child: DropdownButtonHideUnderline(
                   child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    hint: Text(
                  'selectioner un entrepôt',
                  style: TextStyle(
                    color: Color(0xFF8B8B8B), fontSize: 12)
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                     value: selectedName,
                        
                     
                    items: data.map((list) {
                  return DropdownMenuItem(
                  child: new Text(list['deIntitule'],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal)),
                 value: list['deIntitule'],
                  );
                    }).toList(),
                    onChanged: (value){
                            
                       setState(() {
                         _iscolored6=false;
                         _msg='';
                         erreurmsg.clear();
                       });
              
                        for(var i=0;i< data.length;i++){
                           if(data[i]['deIntitule']==value){
                            
                             setState(() {
                                _switchValues[i]=true;
                             });
                           }
                 }
                  setState(() {
                    
               
                  selectedName = value;
                  });
                 
                
                               
                  },
                    style: Theme.of(context).textTheme.title,
                  ),
                   ),
                  ),
                   ),
                ),
                            
         Padding(
                     padding: const EdgeInsets.only(left:8.0,bottom: 8),
                     child: Container(
                  width: 200,
                  
                  child: TextField(
                                     onChanged: (value){
                       setState(() {
                         _iscolored7=false;
                         _msg='';
                         erreurmsg.clear();
                       });
                  },
                    controller: cemployerController,
                      obscureText: false,
                      decoration:new InputDecoration(
                  enabledBorder: _iscolored7==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30))),  
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  
                 
                  
            
                  
                  labelText: 'Code employe',
                  labelStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                  hintText: "entrer votre code employe",
                  hintStyle: TextStyle(
                      color: Color(0xFF8B8B8B), fontSize: 12),
                      ),
                  ),
                     ),
                   ),
                   
                  ],),
      
      
                ],),
              ),
              
      
                Padding(
                  padding: const EdgeInsets.only(left:48.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text('Administrateur :'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 23, top: 20),
                        child: Container(
                          width: 70,
                          height: 35,
                          child: Switch(
                              value: _isDisabled,
                              onChanged: (check) {
                                setState(() { 
                                  _isDisabled = check; 
                                  print(check);
                                  if (_isDisabled == true) {
                                    admin = 1;
                                  } else {
                                    admin = 0;
                                  }
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                
    
              Container(height: 50,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only( bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)))
                ,child: Center(child: Text("Liste des depots",style: TextStyle(fontSize: 18,color: Colors.white)))),
              Padding(
                padding: const EdgeInsets.only(left:35.0,right: 28),
                child: SizedBox(height: 250,
                   child: ListView.builder( shrinkWrap: true,
                              itemCount: data.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                          return  ListTile(
                            leading:Icon(Icons.home_work_sharp),
                            title: Text(data[index]['deIntitule']),
                            trailing:             Switch(value:  _switchValues[index], onChanged:(value){
                          setState(() {
                      _switchValues[index]= value;
                        print( _switchValues[index]);
                               });
                        } ),
                          );
                             
                              }),
                 ),
              ), 
  
                  _isDisabled==false ?      Container(height: 50,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only( bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100)))
                ,child: Center(child: Text("Les Droits D'utilisateur",style: TextStyle(fontSize: 18,color: Colors.white)))):SizedBox.shrink(),
               _isDisabled==false ? Container(child: Row(
                 children: [  
                   Padding(
                     padding: const EdgeInsets.only(left:48.0),
                     child: Column(children:[
             SizedBox(height: 47,child: Center(child: Image.asset(
              'images/in1.png',
              height: 35,
              width: 35,
            ),),),
                SizedBox(height: 47,child: Center(child: Image.asset(
              'images/out2.png',
              height: 35,
              width: 35,
            ),),),
                SizedBox(height: 47,child: Center(child: Image.asset(
              'images/exchange2.png',
              height: 35,
              width: 35,
            ),),),
                SizedBox(height: 47,child: Center(child: Image.asset(
              'images/inventory2.png',
              height: 35,
              width: 35,
            ),),),
                SizedBox(height: 47,child: Center(child: Image.asset(
              'images/his2.png',
              height: 35,
              width: 35,
            ),),),
            
 SizedBox(height: 47,child: Center(child: Icon(
              Icons.verified,size: 35,color: Colors.grey
            ),),),


                     ]),
                   ),
                   
                   SizedBox(width: 25,),
                   Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     
                    SizedBox(height: 47,child: Center(child: Text('Entrée en Stock')),),
                    SizedBox(height: 47,child: Center(child: Text('Sortie du stock')),),
                    SizedBox(height: 47,child: Center(child: Text('Transfert du stock')),),
                    SizedBox(height: 47,child: Center(child: Text('Inventaire')),),
                    SizedBox(height: 47,child: Center(child: Text('Consultation historiques')),),
                    SizedBox(height: 47,child: Center(child: Text('Validation des inventaires')),),
                   ],
               ),
              SizedBox(width: 33,),
                Column(mainAxisAlignment: MainAxisAlignment.center,children:[ 
                   Switch(value: entree, onChanged:(value){
                      setState(() {
                    entree= value;
                    print(entree);
              });
                    } ),
                      Switch(value: sortie, onChanged:(value){
                      setState(() {
                    sortie= value;
                    print(sortie);
              });
                    } ),
                     Switch(value: transfere, onChanged:(value){
                      setState(() {
                   transfere= value;
                    print(transfere);
              });
                    } ),
                     Switch(value: inv, onChanged:(value){
                      setState(() {
                    inv= value;
                    print(inv);
              });
                    } ),
                     Switch(value: consult, onChanged:(value){
                      setState(() {
                   consult= value;
                    print(consult);
              });
                    } ),
                    Switch(value:   validinv, onChanged:(value){
                      setState(() {
                   validinv= value;
                    print(  validinv);
              });
                    } ),
                ],)
                
                
                ],)):SizedBox.shrink(),
                 
              Text(_msg,style: TextStyle(color:Colors.red,fontSize:12,)),
            isloading==false?    Padding(
                  padding: const EdgeInsets.only(top: 20.0,bottom: 50),
                  child: Center(
                    child: Container(
                      child: FlatButton(
                        child: Text('Enregistrer'),
                        color: Color(0xffec524b),
                        textColor: Colors.white,
                        minWidth: 100,
                        height: 50,
                        onPressed: () async {
                         
                                    setState(() {
                                      _msg='';
                                    erreurmsg.clear();
                                    isloading=true;
                                    });
                                     
                                    
                                    if(validate()==true)
                                    
                        {

      if(_isDisabled == true){
                             var rsp = await loginUsdder(data,protmUserController.text, protmPwdController.text, protmDescriptionController.text, protmEmailController.text, protmUserprofilController.text, validinv, admin, selectedName, '${widget.aname}',cemployerController.text);
                            
                            for (var i = 0; i < data.length; i++) {
                              if(_switchValues[i]==true){
                                  
                               
                             await depadd( data[i]['deCode']);
                              }
                              
                             
                            }
                             
                          print(rsp);
                          
                        return successDialog(context, "utilisateur ajouté avec succès",neutralAction:(){ Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  HomeScreen(
                                      aname: "${widget.aname}",
                                      email: "${widget.email}",
                                      url: "${widget.url}",entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,
                                       )),
                                      
                            );
                          } );
                          }else{
                                  
                                var rsp = await loginUsdder(data,protmUserController.text, protmPwdController.text, protmDescriptionController.text, protmEmailController.text, protmUserprofilController.text, validinv, admin, selectedName, '${widget.aname}',cemployerController.text);
                                for (var i = 0; i < data.length; i++) {
                              if(_switchValues[i]==true){
                                  
                               
                             await depadd( data[i]['deCode']);


                      
                              }
                              
                             
                            }
                             await rolesadd();
                          print(rsp);


                          }



setState(() {
  isloading=false;
});


return successDialog(context, "utilisateur ajouté avec succès",neutralAction:(){
   Navigator.pop(context);
   Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                      aname: "${widget.aname}",
                                      email: "${widget.email}",
                                      url: "${widget.url}",entre:widget.entre,
                                                    sortie:widget.sortie,
                                                     transfer:widget.transfer,
                                                      consult:widget.consult,
                                                      inventaires: widget.inventaires,
                                                      gestionutil: widget.gestionutil,
                                                    protvalidation:widget.protvalidation,
                                       )),
                            );
                          } );
                        }  else{


                      msgs(erreurmsg);
                      setState(() {
  isloading=false;
});
                        }                                 
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                               

                         



                         
                         
                         
                         
                        },
                      ),
                    ),
                  ),
                ):CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
