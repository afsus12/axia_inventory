import 'dart:convert';

import 'package:axia_inventory/api.dart';
import 'package:axia_inventory/customWidget.dart';
import 'package:axia_inventory/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  String message = '';
  final protUserController = TextEditingController();
  final protPwdController = TextEditingController();
TextEditingController _ipconfig = TextEditingController();


String uri = '192.168.1.9:8000';
     bool transfere=false;
      bool entree=false;
      bool sortie=false;
      bool inv=false;
      bool consult=false;
      bool gestionutil=false;
      Future getaccess(url,prot) async {
    var response = await http.get(
        Uri.parse(
            "https://$url/api/users/getusers/$prot"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    
   
    print(jsonData);
       
setState(() {
  entree=jsonData["maAccessentree"];
  sortie=jsonData["maAccesssortie"];
    transfere=jsonData["maAccesstransfert"];
     inv=jsonData["maAccessinventaire"];
     consult=jsonData["maAccessconsultaiton"];
     gestionutil=jsonData["maAccessgestionutil"];
});


   
    return "success";
  }
  @override
  void dispose() {
    protUserController.dispose();
    protPwdController.dispose();
    super.dispose();
  }
  

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
              padding: const EdgeInsets.only(top: 120),
              child: Center(
                child: Container(
                    child: Image(
                  image: AssetImage('images/logo2.png'),
                  width: 220,
                )),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: protUserController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'le champ identifiant est vide';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 10,
                                style: BorderStyle.solid,
                              )),
                          labelText: 'Identifiant',
                          hintText: "Entrer l'identifiant"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: protPwdController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'le champ mot de passe est vide';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 10,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Mot de passe',
                          hintText: 'Entrer le mot de passe'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
                    child: Center(
                      child: Container(
                        child: CustomButton(
                          btnText: 'Login',
                          onBtnPressed: () async {
                            if (_formKey.currentState.validate()) {
                              var protUser = protUserController.text;
                              var protPwd = protPwdController.text;
                              setState(() {
                                message = 'please wait ...';
                              });
                              
                              var rsp = await loginUser(protUser, protPwd, uri);
                              print(rsp);

                              if (rsp.statusCode == 200) {
                                var jsondata = jsonDecode(rsp.body);

                                await getaccess(uri, jsondata['name']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu(
                                              aname: jsondata['name'],
                                              email: jsondata['email'],
                                              entre: entree,
                                              sortie: sortie,
                                              transfer: transfere,
                                              consult: consult,
                                              inventaires: inv,
                                              gestionutil: gestionutil,
                                              protvalidation: jsondata['validRight'] ,
                                              url: uri,
                                            )));
                              } else {
                                setState(() {
                                  message = 'Mauvais identifiant / mot de passe';
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){ setState(() {
                    _ipconfig.text=uri;
                  });


 showDialog(context: context, builder: (BuildContext context){
                         return 
                           StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                               return Center(
                               child: SingleChildScrollView(
                                 child: Dialog(
                                    backgroundColor: Colors.transparent,
                                 insetPadding: EdgeInsets.all(2),
                                 child: Stack(
                                   overflow: Overflow.visible,
                                   alignment: Alignment.center,
                                   children: <Widget>[
                                                     
                                    
                                     Container(
                                      width: 380,
                                             
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(15),
                                         color: Colors.white
                                       ),
                                       padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                                     child: Column( mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.only(top:8.0,bottom:18),
                                           child: Text("IP Config",style: TextStyle(fontSize:22,fontWeight: FontWeight.bold),),
                                         ),
                                 
                                                  
                                 Padding(
                                   padding: const EdgeInsets.all(14.0),
                                   child: TextField(onChanged:(value){
                                  setState((){

                                    _ipconfig.text=value;
                                  });
                                   },
                controller: _ipconfig ,
                  obscureText: false,
                  decoration:new InputDecoration(
              enabledBorder:  const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    )
   
    ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),  
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              
             
              
          
              
              labelText: 'Adresse IP',
              labelStyle: TextStyle(
                  color: Color(0xFF8B8B8B), fontSize: 12),
              hintText: "Entrer l'adresse ip de serveur ",
              hintStyle: TextStyle(
                  color: Color(0xFF8B8B8B), fontSize: 12),
                  ),
              ),
                                 ),
                      
                                                Container(  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.blue[500]),
                                       child: FlatButton(
                                           onPressed: () async{
                                  
                                           
                                        
                                         setState((){
                                      uri=_ipconfig.text;
                                           
                                     print(uri);
                                      Navigator.of(context).pop();
                                         });
                                  
                                         }
                                         
                                          
                                       
                                         
                           
                                            ,
                                           
                                           child: Text("Enregistrer",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                     ),      
                                  
                                         ],
                                    ),
                                     ),
                                    
                                    
                                 
                               
                                     Positioned(
                                       top: -70,
                                       child: CircleAvatar(backgroundColor: Colors.grey[350],radius: 60,
                                
                                child: Icon(Icons.connect_without_contact_sharp,size:70,color: Colors.white,)),)
                                    ],),
                                       ),
                                     
                                     
                                   
                                    
                                   
                                   
                                                    ));
                             }
                           );
                        });















                  }, icon: Icon(Icons.settings,size: 30,) ),
                  Text('$message',style:TextStyle(color: Colors.red),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
