import 'package:axia_inventory/inentaireCodefammille.dart';
import 'package:axia_inventory/inventairebarrecode.dart';
import 'package:axia_inventory/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:intl/intl.dart';
import 'menu.dart';
import 'EntréEnStock.dart';
import 'login.dart';
import 'EntréEnStock.dart';
import 'Sortie du stock.dart';
import 'inventaire1.dart';
import 'TrasfertDuStock.dart';
import 'gestion3.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'consultation1.dart';

class inventaire extends StatefulWidget {
  @override
  _inventaireState createState() => _inventaireState();
     final String aname;
  final String email;
  final String url;
  final  bool fa;
  final String nominv;
  
  
inventaire({Key key, this.aname, this.email,this.url,this.fa,this.nominv}) : super(key: key);
}

class _inventaireState extends State<inventaire> {
  
  FocusNode _focusnode;
 
  
   final _piinventaire = TextEditingController();
   
   final _codefa = TextEditingController();
   final _commentaire = TextEditingController();
   final _codeinv = TextEditingController();
  bool _validate = false;
  String depco;

  String selectedName;
    String selectedfa;
  List data = List();
    List data1 = List();
String bingo;
  Future f;

 List famc =List();
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
 golop() async{
if(selectedName!='' && bingo!=selectedName ){
  setState(() {
     bingo=selectedName;
     
  });
 famc= await getAllfa(bingo);
 setState(() {
   selectedfa=famc[0]['faCodefamille'];
 });

 }
 return 'success';
 }


String getInitials({String string, int limitTo})  {
  var buffer = StringBuffer();
  var split = string.split(' ');
  for (var i = 0 ; i < (limitTo ?? split.length); i ++) {
    buffer.write(split[i][0]);
  }

  return buffer.toString();
}

   Future getAllfa(val) async {
    var response = await http.get(
        Uri.parse(
            "https://${widget.url}/api/inventaire/getfamillecode/$val"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    
   
    
    setState(() {
      
      data1 = jsonData;
    });
    print(jsonData);





   
    return data1;
  }


  
  
    @override
  initState() {
  
  getAllName();
    super.initState();
 
    setState(() {
   _piinventaire.text='${widget.nominv}';
    }); 
    
  }
  @override
  Widget build(BuildContext context) {
   
    return  Container(
      child: Padding(
        padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
        child: Container( width:350,
          child: Column(
            children: [
              new Row(crossAxisAlignment: CrossAxisAlignment.start,
              
                children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  
                  SizedBox(height: 42,child: Center(child: Text('Nom inventaire')),),
                  
                  SizedBox(height: 42,child: Center(child: Text('Entrepôt')),),
                  
               SizedBox(height: 42,child:  Center(child: Text('Réference inv')),),
                 
                widget.fa==true ? SizedBox(height: 42,child: Center(child: Text('Code famille')),):SizedBox.shrink(),
                
                 SizedBox(height: 42,child: Center(child: Text('Commentaire'))) 
                ],
              ),
                
               Column(
              children: [
               Padding(
                 padding: const EdgeInsets.only(left:8.0,bottom: 8),
                 child: Container(
              width: 200,
              
              child: TextField(enabled: false,
                controller: _piinventaire ,
                  obscureText: false,
                  decoration:new InputDecoration(
              enabledBorder: _validate==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),  
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              
             
              
          
              
              labelText: 'Nom inventaire',
              labelStyle: TextStyle(
                  color: Color(0xFF8B8B8B), fontSize: 12),
              hintText: 'Enter your  password',
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
                side: _validate==false? BorderSide(
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
                style: _validate == false?TextStyle(
                  color: Color(0xFF8B8B8B), fontSize: 12):TextStyle(
                  color: Colors.red, fontSize: 12),
                  ),
                  icon: _validate==false ? Icon(Icons.arrow_drop_down):Icon(Icons.arrow_drop_down,color: Colors.red),
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
                  onChanged: (value) async{
                setState(() {
                
                selectedName = value;
                });
                var  ref = DateFormat('MMddkkmmss').format(DateTime.now());  
                var na=  getInitials(string: selectedName);       
                                             ref= 'I'+na+ref;
                                   setState(() {
                                     _codeinv.text=ref;
                                   
                                   });    
                                 await  golop();      
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
              height: 35,
              child: TextField(controller: _codeinv,
                 obscureText: false,
                 decoration: InputDecoration(
                   enabledBorder: _validate==false ? const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ): const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.red,  width: 2,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ), border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),   
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              
              labelText: 'Reference inventaire',
              labelStyle: TextStyle(
              color: Color(0xFF8B8B8B), fontSize: 12),
              hintText: 'entrer reference',
              hintStyle: TextStyle(
              color: Color(0xFF8B8B8B), fontSize: 12),
                 ),
              ),
                 ),
               ),
             widget.fa==true ?  Padding(
                padding: const EdgeInsets.only(left:8.0,bottom: 8),
                child: Container(
                width: 200,
                height: 35,
                decoration: ShapeDecoration(
                 shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: _validate==false? BorderSide(
                width: 0.6, style: BorderStyle.solid):BorderSide(
                width: 2, style: BorderStyle.solid,color: Colors.red),
                 ),
                ),
                child: DropdownButtonHideUnderline(
                 child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  hint: Text(
                'selectioner fammille code',
                style: _validate == false?TextStyle(
                  color: Color(0xFF8B8B8B), fontSize: 12):TextStyle(
                  color: Colors.red, fontSize: 12),
                  ),
                  icon: _validate==false ? Icon(Icons.arrow_drop_down):Icon(Icons.arrow_drop_down,color: Colors.red),
                  iconSize: 20,
                   value: selectedfa,
                      
                   
                  items: 
                  
                  famc.map((list) {
                return DropdownMenuItem(
                child: new Text(list['faCodefamille'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal)),
               value: list['faCodefamille'],
                );
                  }).toList(),
                  onChanged: (value) {
                setState(() {
                selectedfa = value;
                });
                  },
                  style: Theme.of(context).textTheme.title,
                ),
                 ),
                ),
                 ),
              ):SizedBox.shrink(),
              
               Padding(
                 padding: const EdgeInsets.only(left:8.0),
                 child: Container(
              width: 200,
              child: new TextField(controller: _commentaire,
                 autofocus: false,
                 focusNode: _focusnode,
                 maxLines: 3,
                 keyboardType: TextInputType.text,
                 minLines: 1,
                 obscureText: false,
                 decoration: InputDecoration(
                   enabledBorder: const OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.grey,  width: 1,style: BorderStyle.solid,),
     borderRadius: BorderRadius.all(Radius.circular(30)),  
   
    ),  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),   
              isDense: true,
              contentPadding: EdgeInsets.all(8),
            
              labelText: 'comment',
              labelStyle: TextStyle(
              color:  Color(0xFF8B8B8B), fontSize: 12),
              hintText: 'commentaire',
              hintStyle: TextStyle(
              color: Color(0xFF8B8B8B), fontSize: 12),
                 ),
              ),
                 ),
               ),
              
               ],
               ),
                ],
              ),
          Padding(
          padding: const EdgeInsets.only(top :10.0),
          child: Container(width: 140, height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.blue),
                child: FlatButton(
                  child:  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Wrap( direction: Axis.horizontal,alignment:WrapAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:1),
                          child: Text('Continuer'),
                        ),SizedBox(width: 7,),Icon(Icons.arrow_forward_ios,size: 20,)
                      ],
                    ),
                  ),
                 
                  textColor: Colors.white,
                  
                  onPressed: () async{  if (_codeinv.text.isEmpty)   { setState(() {
                    _validate = true ;
                  }); } 
                              var i=0;
    while (data[i]['deIntitule'] != selectedName) {
                            i++;
                          }
                          setState(() {
                            depco = data[i]['deCode'];
                          });
                          print(depco);
                   if (widget.fa==false){ 
                     
                     
                     

                 Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => inventairebarrcode(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",fa: widget.fa,nominv: "${widget.nominv}",depot: selectedName,ref: _codeinv.text,comment: _commentaire.text,decode: depco,)),
                            );}else{
             
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => inventairecafa(aname: "${widget.aname}",email: "${widget.email}",url: "${widget.url}",fa: widget.fa,nominv: "${widget.nominv}",depot: selectedName,ref: _codeinv.text,comment: _commentaire.text,decode: depco,familleCode: selectedfa,)),
                            ); }                   
                                        
                  }
                ),
              ),
          )   ,_validate==true?Text('Error Showed if Field is Empty on Submit button Pressed'):SizedBox.shrink(), ],
          ),
        ),
      ),
    );
  }
}
